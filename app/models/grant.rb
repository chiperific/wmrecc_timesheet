class Grant < ApplicationRecord
  validates_presence_of :name

  belongs_to :app_default, validate: true

  has_many :usergrants
  has_many :users, through: :usergrants

  has_many :timesheet_grants
  has_many :timesheets, through: :timesheet_grants

  def payroll_relevant_grants(payroll_start, payroll_end)
    timesheet_ids = Timesheet.where.has { (start_date <= payroll_end) & (end_date >= payroll_start) }.map { |t| t.id } # thanks baby_squeel!!
    TimesheetGrant.where(timesheet_id: timesheet_ids, grant_id: self.id)
  end

  def payroll_hours(payroll_start, payroll_end)
    relevant_ts_grants = self.payroll_relevant_grants(payroll_start, payroll_end)
    if !relevant_ts_grants.blank?
      hours = relevant_ts_grants.sum(:hours).to_f
    else
      hours = 0
    end
    hours
  end

  def payroll_staff_count(payroll_start, payroll_end)
    relevant_ts_grants = self.payroll_relevant_grants(payroll_start, payroll_end)

    ary = []
    relevant_ts_grants.each do |g|
      if g.hours.to_f > 0
        ary << g.timesheet.user.id
      end
    end
    ary.uniq.count
  end

  def payroll_total(start_date, end_date)
    relevant_ts_grants = self.payroll_relevant_grants(start_date, end_date)
    usr_rate_x_hours_ary = []

    relevant_ts_grants.each do |g|
      user_rate = g.timesheet.user.payroll_hourly_rate(start_date)
      usr_rate_x_hours_ary << g.hours * user_rate
    end
    usr_rate_x_hours_ary.sum
  end

end
