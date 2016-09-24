# Code to destroy old timesheets (previous to date). Use Heroku console.
# date = Date.new(2015,7,1)
# t = Timesheet.where( "start_date < ?", date)
# ary = t.map { |t| t.id }
# Timesheet.delete(ary)
