# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161209023413) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_defaults", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "department_id"
    t.boolean  "active",                    default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["department_id"], name: "index_categories_on_department_id", using: :btree
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "active",                 default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grants", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",         default: true
    t.integer  "app_default_id", default: 1
    t.integer  "integer",        default: 1
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "holidays", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "month"
    t.integer  "day"
    t.integer  "app_default_id",             default: 1
    t.boolean  "floating",                   default: false
    t.integer  "float_week"
    t.integer  "float_day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "it_emails", force: :cascade do |t|
    t.string   "email",          limit: 255
    t.integer  "app_default_id",             default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pay_periods", force: :cascade do |t|
    t.string  "period_type",    limit: 255, default: "Bi-weekly"
    t.integer "app_default_id",             default: 1
  end

  create_table "start_months", force: :cascade do |t|
    t.string   "month",          limit: 255, default: "January"
    t.integer  "app_default_id",             default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timeoff_accruals", force: :cascade do |t|
    t.string  "accrual_type",   limit: 255, default: "Annual"
    t.integer "app_default_id",             default: 1
  end

  create_table "timesheet_categories", force: :cascade do |t|
    t.integer  "timesheet_id"
    t.integer  "category_id"
    t.decimal  "hours",        precision: 4, scale: 2, default: "0.0"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category_id"], name: "index_timesheet_categories_on_category", using: :btree
    t.index ["timesheet_id"], name: "index_timesheet_categories_on_timesheet", using: :btree
  end

  create_table "timesheet_grants", force: :cascade do |t|
    t.integer  "timesheet_id"
    t.integer  "grant_id"
    t.decimal  "hours"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["grant_id"], name: "index_timesheet_grants_on_grant_id", using: :btree
    t.index ["timesheet_id"], name: "index_timesheet_grants_on_timesheet_id", using: :btree
  end

  create_table "timesheet_hours", force: :cascade do |t|
    t.integer  "timesheet_id"
    t.integer  "day_num"
    t.decimal  "hours",         precision: 4, scale: 2, default: "0.0"
    t.decimal  "timeoff_hours", precision: 4, scale: 2, default: "0.0"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["timesheet_id"], name: "index_timesheet_hours_on_timesheet", using: :btree
  end

  create_table "timesheets", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "user_id"
    t.date     "hours_approved"
    t.date     "timeoff_approved"
    t.date     "hours_reviewed"
    t.date     "timeoff_reviewed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usergrants", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "grant_id"
    t.boolean  "active",     default: false
    t.decimal  "percent",    default: "0.0"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["grant_id"], name: "index_usergrants_on_grant_id", using: :btree
    t.index ["user_id"], name: "index_usergrants_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "fname",             limit: 255
    t.string   "lname",             limit: 255
    t.boolean  "active",                                                 default: true
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "department_id"
    t.integer  "supervisor_id"
    t.string   "email",             limit: 255
    t.string   "password_digest",   limit: 255
    t.boolean  "admin",                                                  default: false
    t.decimal  "annual_time_off",               precision: 6,  scale: 2, default: "0.0"
    t.decimal  "standard_hours",                precision: 6,  scale: 2, default: "40.0"
    t.decimal  "salary_rate",                   precision: 10, scale: 2
    t.decimal  "hourly_rate",                   precision: 6,  scale: 2
    t.string   "pay_type",          limit: 255,                          default: "Salary"
    t.string   "time_zone",         limit: 255,                          default: "Eastern Time (US & Canada)"
    t.string   "remember_token",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "timeoff_carryover",             precision: 5,  scale: 2, default: "0.0"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  create_table "weekdays", force: :cascade do |t|
    t.integer "app_default_id",             default: 1
    t.string  "name",           limit: 255
    t.string  "abbr",           limit: 255
    t.integer "day_num"
    t.boolean "active",                     default: true
  end

end
