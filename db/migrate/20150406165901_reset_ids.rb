class ResetIds < ActiveRecord::Migration
  def change
    # Reset all the primary ID keys based upon seeded data.
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end
end
