class Timesheet < ActiveRecord::Base
  has_many :timesheet_hours, inverse_of: :timesheet, dependent: :destroy

  has_many :timesheet_categories, inverse_of: :timesheet, dependent: :destroy
  has_many :categories, through: :timesheet_categories

  has_many :timesheet_grants, inverse_of: :timesheet, dependent: :destroy
  has_many :grants, through: :timesheet_grants

  belongs_to :user

  accepts_nested_attributes_for :timesheet_hours, :timesheet_categories, :timesheet_grants, allow_destroy: true

  validates :start_date, :end_date, :user_id, presence: true

  def status
    if self.hours_approved.present?
      self.hours_approved.strftime("%m/%d/%Y")
    elsif self.hours_reviewed.present?
      "Denied"
    else
      "Unreviewed"
    end
  end

  def status_to
    if self.timeoff_approved.present?
      self.timeoff_approved.strftime("%m/%d/%Y")
    elsif self.timeoff_reviewed.present?
      "Denied"
    else
      "Unreviewed"
    end
  end
end
