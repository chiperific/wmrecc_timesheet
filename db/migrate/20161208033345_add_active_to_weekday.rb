class AddActiveToWeekday < ActiveRecord::Migration[5.0]
  def change
    add_column :weekdays, :active, :boolean, default: true
  end
end
