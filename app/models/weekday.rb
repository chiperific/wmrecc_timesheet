class Weekday < ActiveRecord::Base
  validates_presence_of :name, :abbr, :day_num
  validates_inclusion_of :name, in: Date::DAYNAMES

  belongs_to :app_default, validate: true
end
