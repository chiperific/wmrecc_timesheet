class Weekday < ActiveRecord::Base
  validates :name, presence: true
end