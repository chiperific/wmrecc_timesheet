class CreateUsergrants < ActiveRecord::Migration[5.0]
  def change
    create_table :usergrants do |t|
      t.belongs_to :user
      t.belongs_to :grant
      t.boolean :active, default: false
      t.decimal :percent, default: 0
      t.timestamps
    end
  end
end
