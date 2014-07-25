class AddToApprovedToTimesheetHours < ActiveRecord::Migration
  def change
    add_column :timesheet_hours, :timeoff_approved, :datetime
  end
end
