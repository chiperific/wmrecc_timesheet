class Weekday < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :app_default
end