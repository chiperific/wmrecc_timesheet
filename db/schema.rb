# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140617004130) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "department_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["department_id"], name: "index_categories_on_department_id"

  create_table "departments", force: true do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", force: true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.integer  "hours"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sv_approval", default: false
    t.boolean  "sv_reviewed", default: false
  end

  create_table "users", force: true do |t|
    t.string   "fname"
    t.string   "lname"
    t.boolean  "active"
    t.integer  "department_id"
    t.integer  "supervisor_id"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.boolean  "admin",                                    default: false
    t.string   "remember_token"
    t.decimal  "annual_time_off", precision: 6,  scale: 2
    t.decimal  "standard_hours",  precision: 6,  scale: 2
    t.decimal  "salary_rate",     precision: 10, scale: 2
    t.decimal  "hourly_rate",     precision: 6,  scale: 2
    t.boolean  "pay_type",                                 default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
