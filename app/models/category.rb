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
    if relevant_ts_cats.any?
      summed_hsh = relevant_ts_cats.group_by(&:timesheet_id).sum(:hours)
    else
      summed_hsh = {}
    end
    summed_hsh.map { |k, v| v.to_f }.sum
  end

  def payroll_total(start_date, end_date, period, year)
    relevant_ts_cats = self.payroll_relevant_cats(start_date, end_date)
    usr_rate_x_hours_ary = []
    relevant_ts_cats.each do |c|
      user_rate = c.user.payroll_hourly_rate(period, year)
      usr_rate_x_hours_ary << c.hours * user_rate
    end
    usr_rate_x_hours_ary.sum
  end

end
