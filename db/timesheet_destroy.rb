# Code to destroy old timesheets (previous to date). Use Heroku console.
date = Date.new(2015,7,1)
t = Timesheet.where( "start_date < ?", date)
ary = t.map { |t| t.id }
th = []
td = []
t.each do |t|
  th << t.timesheet_hours.count
  td << t.timesheet_categories.count
end
ttl = ary.count + th.sum + td.sum
puts "#{ary.count} Timesheets, #{th.sum} TimesheetHours, #{td.sum} TimesheetCategories, #{ttl} Records"

Timesheet.delete(ary)

# Check database row count
aryCount = []
aryText = []
ActiveRecord::Base.connection.tables.each do |table|
  next if table.match(/\Aschema_migrations\Z/)
  klass = table.singularize.camelize.constantize
  aryCount << klass.count
  aryText << "#{klass.name} has #{klass.count} records"
end
aryText << "Total of #{aryCount.sum} Records"
aryText.each do |a|
  puts a
end

# If dependent: destroy fails
thAry = []
TimesheetHour.all.each do |th|
  if th.timesheet == nil
    thAry << th.id
    TimesheetHour.destroy(th.id)
  end
end

tcAry = []
TimesheetCategory.all.each do |tc|
  if tc.timesheet == nil
    tcAry << tc.id
    TimesheetCategory.destroy(tc.id)
  end
end

p "#{thAry.count} TimesheetHours removed, #{tcAry.count} TimesheetCategories removed."
