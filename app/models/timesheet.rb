class Timesheet < ActiveRecord::Base
  has_many :timesheet_hours, inverse_of: :timesheet
  has_many :timesheet_categories, inverse_of: :timesheet
  belongs_to :user

  accepts_nested_attributes_for :timesheet_hours, :timesheet_categories, allow_destroy: true

  validates :start_date, :end_date, presence: true

  def status
    if self.hours_approved.present?
      self.hours_approved.strftime("%m/%d/%Y")
    elsif self.hours_reviewed.present?
      "Denied"
    else
      "Unreviewed"
    end
  end
end
