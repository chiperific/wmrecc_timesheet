# Timeshift
#### spage-age time tracking for all types of organizations.

## Created 2015 by Chiperific
#### [Chiperific](http://chiperific.com) \[software\]\[web\]\[database\]
&copy; under the [MIT License](http://opensource.org/licenses/MIT)


To Do:
* Grant time tracking:
1. Add VISIBLE grants to user profiles (not saving)
2. Add VISIBLE grants to timesheets
2.1 Handle progress bar for grant hours? At least warning message when grant hours > hours worked
3. Add VISIBLE grants to payroll

* Protecting weekdays:
1. Trim to VISIBLE workdays in timesheets
2. Trim to VISIBLE workdays in payroll
3. Trim to VISIBLE workdays in ???

* Update Prod env
1. Force use of current schema (>heroku run rake db:migrate)
2. Check the Config page to make sure holidays and grants are correct
