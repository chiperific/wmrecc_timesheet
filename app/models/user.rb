class User < ActiveRecord::Base
  include StaticPagesHelper

  belongs_to :department 
  has_many :categories, through: :department
  has_many :timesheets

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :fname, :lname, :start_date, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name)

  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true

  default_value_for :start_date do
    Date.today
  end

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

  def end_date_string
    if self.end_date.present?
      self.end_date.strftime("%m/%d/%Y")
    else
      "present"
    end
  end

  ############ methods for _timeoff_calculator
  # return the amount of timeoff accumulated to this date based upon accrual_type: ["Annual", "Weekly", "Bi-weekly"]
  def timeoff_accumulated(date)
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

  # accrual_type: ["Annual", "Weekly", "Bi-weekly"]
  def timeoff_earned_per_period(date)
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
  def timeoff_approved_by_year(date)
    timesheets = self.timesheets.where("extract(year from start_date) = ?", date.year).where.not(timeoff_approved: nil)
    if timesheets.any? 
      ary = []
      timesheets.each do |t|
        ary << t.timesheet_hours.sum(:timeoff_hours).to_f
      end
      ary.sum
    else
      0
    end
  end

  def timeoff_unapproved_by_year(date)
    timesheets = self.timesheets.where("extract(year from start_date) = ?", date.year).where(timeoff_approved: nil)
    if timesheets.any? 
      ary = []
      timesheets.each do |t|
        ary << t.timesheet_hours.sum(:timeoff_hours).to_f
      end
      ary.sum
    else
      0
    end
  end

  def timsheets_w_timeoff_unapproved_by_year(date)
    timesheets = self.timesheets.where("extract(year from start_date) = ?", date.year).where(timeoff_approved: nil)
    count = 0
    timesheets.each do |t|
      count =+ 1 unless t.timesheet_hours.sum(:timeoff_hours) == 0
    end
    count
  end

  def timeoff_used_by_period(date)
    date_ary = [date.start_of_period..date.end_of_period]
    timesheets = self.timesheets.where.not(timeoff_approved: nil).where( start_date: date_ary)
    if timesheets.any? 
      ary = []
      timesheets.each do |t|
        ary << t.timesheet_hours.sum(:timeoff_hours).to_f
      end
      ary.sum
    else
      0
    end
  end

  def timeoff_used_to_period(date)
    start_of_year = Date.new(date.year, 1, 1)
    date_ary = [start_of_year..date.end_of_period]
    timesheets = self.timesheets.where.not(timeoff_approved: nil).where( start_date: date_ary)
    if timesheets.any? 
      ary = []
      timesheets.each do |t|
        ary << t.timesheet_hours.sum(:timeoff_hours).to_f
      end
      ary.sum
    else
      0
    end
  end

  ############ methods for payroll_users
  def payroll_hours(payroll_start, payroll_end)
    timesheets = self.timesheets.where{ (start_date <= payroll_end) & (end_date >= payroll_start) } # thanks Squeel!!
    if timesheets.any?
      hours = []
      timesheets.each do |t| 
        hours << t.timesheet_hours.sum(:hours)
      end
      hours.inject(:+)
    else 
      0 
    end
  end

  # used to find payroll rate
  def val_from_period_type
    options = {
      "Weekly" => 52,
      "Bi-weekly" => 26,
      "Semi-monthly" => 24,
      "Monthly" => 12,
      "Annually" => 1
    }
    period_type = PayPeriod.first.period_type
    options[period_type]
  end

  def payroll_rate
    if self.pay_type == "Hourly"
      if self.hourly_rate != nil
        rate = self.hourly_rate
      else
        rate = 0.0
      end
    else
      if self.salary_rate != nil
        rate = self.salary_rate / self.val_from_period_type
      else
        rate = 0.0
      end
    end
    rate.round(2)
  end

  def payroll_hourly_rate(start_date)
    if self.pay_type == "Hourly"
      if self.hourly_rate != nil
        rate = self.hourly_rate
      else
        rate = 0.0
      end
    else #salary
      if self.salary_rate != nil
        # Date.instance.business_days returns number of working days in year
        # business_days * 8 give working hours in year
        working_hours = start_date.business_days_in_year * 8
        # divide working hours
        rate = self.salary_rate / working_hours
      else
        rate = 0.0
      end
    end
    rate.round(2)
  end

  def payroll_gross(start_date, end_date)
    if self.pay_type == "Hourly"
      rate = self.hourly_rate * self.payroll_hours(start_date, end_date)
    else
      rate = self.payroll_rate
    end
    rate.round(2)
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