class Weekday < ActiveRecord::Base
  validates :name, :abbr, :app_default_id, presence: true

  belongs_to :app_default, validate: true
end