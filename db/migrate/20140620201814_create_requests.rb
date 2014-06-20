class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.date :date
      t.integer :hours

      t.timestamps
    end
  end
end
