# Timeshift
#### spage-age time tracking for all types of organizations.

## Created 2015 by Chiperific
#### [Chiperific](http://chiperific.com) \[software\]\[web\]\[database\]
&copy; under the [MIT License](http://opensource.org/licenses/MIT)


To Do:
* Grant time tracking:
1.1 CHANGE TO "ACCOUNT"
1.2 Make Account come before Category in _user_form (and deal with col-* horizontal collapse (wrap in row))
1.3 Delete bad Categories

* Protecting weekdays:
1. Trim to VISIBLE workdays in timesheets
2. Trim to VISIBLE workdays in payroll
3. Trim to VISIBLE workdays in ???

* Update Prod env
1. Force use of current schema (>heroku run rake db:migrate)
2. Check the Config page to make sure holidays and grants are correct
