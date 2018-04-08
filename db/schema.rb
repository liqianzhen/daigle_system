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

ActiveRecord::Schema.define(version: 20180406031813) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "pen_id"
    t.datetime "check_in"
    t.datetime "check_out"
    t.integer  "pen_pull_num"
    t.integer  "pen_dead_num"
    t.boolean  "pen_feed_check"
    t.boolean  "pen_water_check"
    t.boolean  "pen_mud_check"
    t.boolean  "pen_maintenance_check"
  end

  add_index "activities", ["pen_id"], name: "index_activities_on_pen_id"
  add_index "activities", ["user_id"], name: "index_activities_on_user_id"

  create_table "maintenance_calls", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "activitie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "reseolved"
  end

  add_index "maintenance_calls", ["activitie_id"], name: "index_maintenance_calls_on_activitie_id"
  add_index "maintenance_calls", ["user_id"], name: "index_maintenance_calls_on_user_id"

  create_table "mortality_alerts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "activitie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "reseolved"
    t.text     "reseolved_comment"
  end

  add_index "mortality_alerts", ["activitie_id"], name: "index_mortality_alerts_on_activitie_id"
  add_index "mortality_alerts", ["user_id"], name: "index_mortality_alerts_on_user_id"

  create_table "mud_calls", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "activitie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "reseolved"
    t.text     "reseolved_comment"
  end

  add_index "mud_calls", ["activitie_id"], name: "index_mud_calls_on_activitie_id"
  add_index "mud_calls", ["user_id"], name: "index_mud_calls_on_user_id"

  create_table "pens", force: :cascade do |t|
    t.integer "num"
    t.integer "total_num"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.boolean  "cowboy"
    t.boolean  "handy"
    t.boolean  "doctor"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.text     "address"
  end

end
