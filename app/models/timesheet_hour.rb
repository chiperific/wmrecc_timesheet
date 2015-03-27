class TimesheetHour < ActiveRecord::Base
  belongs_to :timesheet

  validates :day_num, presence: true
  validates :day_num, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 7 }
  validates :hours, :timeoff_hours, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 24 }

end
