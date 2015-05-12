class ResetUserIds < ActiveRecord::Migration
  def change
    ActiveRecord::Base.connection.reset_pk_sequence!('users')
  end
end
