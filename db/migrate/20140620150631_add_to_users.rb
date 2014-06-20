class AddToUsers < ActiveRecord::Migration
  def change
    add_column :users, :annual_time_off, :integer
    add_column :users, :standard_hours, :integer
  end
end
