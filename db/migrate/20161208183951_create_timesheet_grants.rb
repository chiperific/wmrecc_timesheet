class CreateTimesheetGrants < ActiveRecord::Migration[5.0]
  def change
    create_table :timesheet_grants do |t|
      t.belongs_to :timesheet, index: true
      t.belongs_to :grant, index: true
      t.decimal :hours
      t.timestamps
    end
  end
end
