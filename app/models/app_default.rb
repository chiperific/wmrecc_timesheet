class AppDefault < ActiveRecord::Base
  validates :name, presence: true

  has_many :weekdays
  has_many :start_months
  has_many :it_emails

  accepts_nested_attributes_for :weekdays, allow_destroy: true
  accepts_nested_attributes_for :start_months, :it_emails
end