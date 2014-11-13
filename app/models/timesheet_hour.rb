class TimesheetHour < ActiveRecord::Base
  belongs_to :timesheet
  belongs_to :user

  validates :user_id, :weekday, :hours, presence: true
  validates :weekday, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 7 }
  validates :hours, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 24 }

  def status
    if self.approved.present?
      self.approved.strftime("%m/%d/%Y")
    elsif self.reviewed.present?
      "Denied"
    else
      "Unreviewed"
    end
  end

end
