class AddToRequestsTable < ActiveRecord::Migration
  def change
    add_column :requests, :sv_denied, :boolean, default: false
  end
end
