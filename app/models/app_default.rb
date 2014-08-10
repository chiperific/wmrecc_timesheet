class AppDefault < ActiveRecord::Base
  validates :name, presence: true

  has_many :weekdays

  accepts_nested_attributes_for :weekdays, allow_destroy: true
end