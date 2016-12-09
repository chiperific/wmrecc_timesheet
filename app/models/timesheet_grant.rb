class TimesheetGrant < ApplicationRecord
  belongs_to :timesheet
  belongs_to :grant
  has_one :user, through: :timesheet

  validates :grant_id, presence: true
  validates :hours, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 168 }
end
