class Weekday < ActiveRecord::Base
  validates_presence_of :name, :abbr, :app_default_id

  belongs_to :app_default, validate: true
end