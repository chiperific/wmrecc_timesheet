class Category < ActiveRecord::Base
  belongs_to :department

  validates :name, :department_id, :active, presence: true

  def payroll_timesheet_id_ary(start_date, end_date)
    year = (start_date.year..end_date.year).map { |y| y }
    cweek = (start_date.cweek..end_date.cweek).map { |c| c }
    timesheet_ids = Timesheet.where(year: year, week_num: cweek).map { |t| t.id }
  end

  def payroll_hours(start_date, end_date)
    timesheet_ids = self.payroll_timesheet_id_ary(start_date, end_date)
    summed_hsh = TimesheetCategory.where(timesheet_id: timesheet_ids, category_id: self.id).group(:timesheet_id).sum(:hours)
    summed_hsh.map { |k, v| v.to_f }.sum
  end

  def payroll_total
    #use user.payroll_hourly_rate * user's contributed hours
  end

end
