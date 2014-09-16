class Category < ActiveRecord::Base
  belongs_to :department

  validates :name, :department_id, :active, presence: true

  def payroll_relevant_cats(start_date, end_date)
    year = (start_date.year..end_date.year).map { |y| y }
    cweek = (start_date.cweek..end_date.cweek).map { |c| c }
    timesheet_ids = Timesheet.where(year: year, week_num: cweek).map { |t| t.id }
    TimesheetCategory.where(timesheet_id: timesheet_ids, category_id: self.id)
  end

  def payroll_hours(start_date, end_date)
    relevant_ts_cats = self.payroll_relevant_cats(start_date, end_date)
    summed_hsh = relevant_ts_cats.group(:timesheet_id).sum(:hours)
    summed_hsh.map { |k, v| v.to_f }.sum
  end

  def payroll_total(start_date, end_date)
    relevant_ts_cats = self.payroll_relevant_cats(start_date, end_date)
    #use user.payroll_hourly_rate * user's contributed hours per user's timesheet_category
    # create new ary with user's contributed total per relevant TimesheetCategory record?
    # { user_cont_$ => TimesheetCategory.id }
  end

end
