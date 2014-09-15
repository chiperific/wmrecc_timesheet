class User < ActiveRecord::Base
  include StaticPagesHelper

  belongs_to :department 
  has_many :categories, through: :department
  has_many :timesheet_hours
  has_many :timesheet_categories

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :fname, :lname, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name)

  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true

  def has_authority_over
    if User.where(supervisor_id: self.id, active: true).exists?
      User.where(supervisor_id: self.id, active: true)
    else
      []
    end
  end

  def has_authority_over?(user)
    if self.has_authority_over.any?
      @users_ary = self.has_authority_over
      
      if @users_ary.where(id: user.id).exists?
        true
      else
        false
      end

    else
      false
    end
  end

  def can_approve_this?(source)
    # if self is an admin but not accessing their own source
    # if self has authority over the source
    if (self.admin && self.id != source.id ) || self.has_authority_over?(source)
      true
    # if self doesn't have a supervisor and is accessing their own source
    elsif self.supervisor_id == nil && self.id == source.id
      true
    else
      false
    end
  end

  def can_change_admin_status(user)
    #self cannot change own admin status
    #non-admins cannot change status
    if self == user || !self.admin?
      false
    else
      true
    end
  end

  def full_name
    "#{self.fname} #{self.lname}"
  end

  ############ methods for _timeoff_calculator
  # turn 'mm-dd' and 'yyyy' into a date
  def date_from_period_year(period, year)
    m_d = period.split('-')
    m = m_d[0].to_i
    d = m_d[1].to_i
    year = year.to_i
    date = Date.new(year,m,d)
  end

  # return the amount of timeoff accumulated to this date based upon accrual_type
  def timeoff_accumulated(period, year)
    date = date_from_period_year(period, year)
    if TimeoffAccrual.first.accrual_type == "Weekly"
      weekly = (self.annual_time_off / 52.0 ).to_f
      accumulated = (date.fweek * weekly).round(2)
    elsif TimeoffAccrual.first.accrual_type == "Bi-weekly"
      bi_weekly = (self.annual_time_off / 26.0 ).to_f
      accumulated = ((date.fweek.to_f / 2.0).round(0) * bi_weekly).round(2)
    else
      accumulated = self.annual_time_off
    end
    accumulated
  end

  def timeoff_earned_per_period(period, year)
    date = date_from_period_year(period, year)
    if TimeoffAccrual.first.accrual_type == "Weekly"
      earned = ((self.annual_time_off / 52.0 ).to_f).round(2)
    elsif TimeoffAccrual.first.accrual_type == "Bi-weekly"
      earned = ((self.annual_time_off / 26.0 ).to_f).round(2)
    else
      earned = self.annual_time_off
    end
  end

  ############ methods for timeoff views
  def timeoff_approved_by_year(year)
    if year.class == String
      year = year.to_i
    end
    self.timesheet_hours.joins(:timesheet).where( timesheets: { year: year}).where.not(timeoff_approved: nil).sum(:timeoff_hours).to_f
  end

  def timeoff_unapproved_by_year(year)
    if year.class == String
      year = year.to_i
    end
    self.timesheet_hours.joins(:timesheet).where( timesheets: { year: year}).where(timeoff_approved: nil).sum(:timeoff_hours).to_f
  end

  def timsheets_w_timeoff_unapproved_by_year(year)
    if year.class == String
      year = year.to_i
    end
    self.timesheet_hours.joins(:timesheet).where( timesheets: { year: year}).where(timeoff_approved: nil).group(:timesheet_id).map { |a| a.id }.count
  end

  def timeoff_used_by_period(period, year)
    date = date_from_period_year(period, year)
    if date.fweek.even?
      wk1 = (date - 7.days).fweek
      wk2 = date.fweek
    else
      wk1 = date.fweek
      wk2 = (date + 7.days).fweek
    end
    week_num_ary = [wk1, wk2]
    self.timesheet_hours.joins(:timesheet).where.not(timeoff_approved: nil).where( timesheets: { year: year, week_num: week_num_ary}).sum(:timeoff_hours).to_f
  end

  def timeoff_used_to_period(period, year)
    date = date_from_period_year(period, year)
    if date.fweek.even?
      pay_period = (date - 7.days).fweek
    else
      pay_period = date.fweek
    end
    pay_period_ary = [1...pay_period]
    self.timesheet_hours.joins(:timesheet).where.not(timeoff_approved: nil).where( timesheets: { year: year, week_num: pay_period_ary}).sum(:timeoff_hours).to_f
  end

  ############ methods for payroll_users
  def val_from_period_type(period_string)
    options = {
      "Weekly" => 52,
      "Bi-weekly" => 26,
      "Semi-monthly" => 24,
      "Monthly" => 12
    }
    options[period_string]
  end

  def payroll_hours(year, cweek)
    # only checks one timesheet
    # doesn't check for user
    # needs to look for every timesheet within the year_ary and cweek_ary
    timesheet = Timesheet.where(year: year).where(week_num: cweek).first
    pay_period_type = AppDefault.first.pay_periods.first.period_type


    if !timesheet.nil?
      timesheet_hour = self.timesheet_hours.where(timesheet_id: timesheet.id)
      hours = timesheet_hour.sum(:hours)
    else
      hours = 0
    end
    hours.to_f
  end

  def payroll_rate(year, cweek)
    payroll_hours = self.payroll_hours(year, cweek)
    pay_period = AppDefault.first.pay_periods.first.period_type
    if self.pay_type == "Salary"
      rate = self.salary_rate.to_f
    else
      rate = self.hourly_rate.to_f
    end
    rate
  end

  def payroll_gross
    pay_period_type = AppDefault.first.pay_periods.first.period_type
    val = val_from_period_type(pay_period_type)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end

    def User.new_remember_token
      SecureRandom.urlsafe_base64
    end

    def User.digest(token)
      Digest::SHA1.hexdigest(token.to_s)
    end
end
