class CreateTimesheetTables < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.integer :week_num
      t.integer :year
    end

    create_table :timesheet_hours do |h|
      h.belongs_to :timesheet
      h.belongs_to :user
      h.integer :weekday
      h.decimal :hours, precision: 4, scale: 2
      h.boolean :approved, default: false
      h.timestamps
    end

    create_table :timesheet_categories do |c|
      c.belongs_to :timesheet
      c.belongs_to :user
      c.belongs_to :category
      c.boolean :approved, default: false
      c.timestamps
    end

    change_column :requests, :hours, :decimal, precision: 4, scale: 2

    add_index :timesheet_hours, [:timesheet_id], name: "index_timesheet_hours_on_timesheet"
    add_index :timesheet_hours, [:user_id], name: "index_timesheet_hours_on_user"

    add_index :timesheet_categories, [:timesheet_id], name: "index_timesheet_categories_on_timesheet"
    add_index :timesheet_categories, [:user_id], name: "index_timesheet_categories_on_user"
    add_index :timesheet_categories, [:category_id], name: "index_timesheet_categories_on_category"
  end
end
