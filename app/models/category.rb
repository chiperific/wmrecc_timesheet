class Category < ActiveRecord::Base
  belongs_to :department
  has_many :timesheet_categories
  has_many :timesheets, through: :timesheet_categories

  validates :name, :department_id, :active, presence: true

  def payroll_relevant_cats(payroll_start, payroll_end)
    timesheet_ids = Timesheet.where.has { (start_date <= payroll_end) & (end_date >= payroll_start) }.map { |t| t.id } # thanks baby_squeel!!
    TimesheetCategory.where(timesheet_id: timesheet_ids, category_id: self.id)
  end

  def payroll_hours(payroll_start, payroll_end)
    relevant_ts_cats = self.payroll_relevant_cats(payroll_start, payroll_end)
    if !relevant_ts_cats.blank?
      hours = relevant_ts_cats.sum(:hours).to_f
    else
      hours = 0
    end
    hours
  end

  def payroll_staff_count(payroll_start, payroll_end)
    relevant_ts_cats = self.payroll_relevant_cats(payroll_start, payroll_end)

    ary = []
    relevant_ts_cats.each do |c|
      if c.hours.to_f > 0
        ary << c.timesheet.user.id
      end
    end
    ary.uniq.count
  end

  def payroll_total(start_date, end_date)
    relevant_ts_cats = self.payroll_relevant_cats(start_date, end_date)
    usr_rate_x_hours_ary = []

    relevant_ts_cats.each do |c|
      user_rate = c.timesheet.user.payroll_hourly_rate(start_date)
      usr_rate_x_hours_ary << c.hours * user_rate
    end
    usr_rate_x_hours_ary.sum
  end

end
