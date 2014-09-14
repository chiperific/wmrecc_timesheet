class AppDefault < ActiveRecord::Base
  validates :name, presence: true

  has_many :weekdays
  has_many :start_months
  has_many :it_emails
  has_many :timeoff_accruals
  has_many :pay_periods
  has_many :holidays

  accepts_nested_attributes_for :weekdays, :holidays, allow_destroy: true
  accepts_nested_attributes_for :start_months, :it_emails, :timeoff_accruals, :pay_periods
end