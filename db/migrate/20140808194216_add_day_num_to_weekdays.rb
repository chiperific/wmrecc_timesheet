class AddDayNumToWeekdays < ActiveRecord::Migration
  def change
    add_column :weekdays, :day_num, :integer
  end
end
