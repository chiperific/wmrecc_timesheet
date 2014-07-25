class TimesheetHour < ActiveRecord::Base
  belongs_to :timesheet
  belongs_to :user

  validates :user_id, :weekday, :hours, presence: true
  validates :weekday, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 7 }
  validates :hours, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 24 }

  def day_name(weekday)
    day_ary_hash = {
      1 => "Monday", 
      2 => "Tuesday", 
      3 => "Wednesday", 
      4 => "Thursday", 
      5 => "Friday", 
      6 => "Saturday", 
      7 => "Sunday"}
    day_ary_hash[weekday]
  end

  def self.day_name(weekday)
    day_ary_hash = {
      1 => "Monday", 
      2 => "Tuesday", 
      3 => "Wednesday", 
      4 => "Thursday", 
      5 => "Friday", 
      6 => "Saturday", 
      7 => "Sunday"}
    day_ary_hash[weekday]
  end

  def day_name_abbr(weekday)
    day_ary_hash = {
      1 => "Mon", 
      2 => "Tue", 
      3 => "Wed", 
      4 => "Thu", 
      5 => "Fri", 
      6 => "Sat", 
      7 => "Sun"}
    day_ary_hash[weekday]
  end

  def self.day_name_abbr(weekday)
    day_ary_hash = {
      1 => "Mon", 
      2 => "Tue", 
      3 => "Wed", 
      4 => "Thu", 
      5 => "Fri", 
      6 => "Sat", 
      7 => "Sun"}
    day_ary_hash[weekday]
  end

end
