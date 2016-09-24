# Code to destroy old timesheets (previous to date). Use Heroku console.
# date = Date.new(2015,7,1)
# t = Timesheet.where( "start_date < ?", date)
# ary = t.map { |t| t.id }
# ary.count
# Timesheet.delete(ary)

# Check database row count
# aryCount = []
# aryText = []
# ActiveRecord::Base.connection.tables.each do |table|
#   next if table.match(/\Aschema_migrations\Z/)
#   klass = table.singularize.camelize.constantize
#   aryCount << klass.count
#   aryText << "#{klass.name} has #{klass.count} records"
# end
# aryText << "Total of #{aryCount.sum} Records"
# aryText.each do |a|
#   puts a
# end
