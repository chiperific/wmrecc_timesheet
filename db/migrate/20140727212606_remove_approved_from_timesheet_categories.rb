class RemoveApprovedFromTimesheetCategories < ActiveRecord::Migration
  def change
    remove_column :timesheet_categories, :approved
  end
end
