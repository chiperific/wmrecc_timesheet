class ResetIds < ActiveRecord::Migration
  def change
    # Reset all the primary ID keys based upon seeded data.
    ActiveRecord::Base.connection.reset_pk_sequence!('timesheets')
    ActiveRecord::Base.connection.reset_pk_sequence!('timesheet_hours')
    ActiveRecord::Base.connection.reset_pk_sequence!('timesheet_categories')
    ActiveRecord::Base.connection.reset_pk_sequence!('users')
  end
end
