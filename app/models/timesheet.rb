class Timesheet < ActiveRecord::Base

  #accepts_nested_attributes_for :timesheet_hours
  #accepts_nested_attributes_for :timesheet_categories

  validates :week_num, :year, presence: true
  validates :week_num, numericality: { greater_than: 0, less_than_or_equal_to: 52 }
  validates :year, numericality: { greater_than_or_equal_to: 1900, less_than_or_equal_to: 2999 }

  def week_num_to_date(week_num, year)
    Date.commercial(year, week_num, 1).strftime("%m/%d/%Y")
  end
end
