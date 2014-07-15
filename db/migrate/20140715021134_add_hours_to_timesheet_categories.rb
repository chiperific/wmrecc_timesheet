class AddHoursToTimesheetCategories < ActiveRecord::Migration
  def change
    add_column :timesheet_categories, :hours, :decimal, precision: 4, scale: 2
  end
end
