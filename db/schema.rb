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

ActiveRecord::Schema.define(version: 20140806082347) do

  create_table "courts", force: true do |t|
    t.string   "name"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "skill_level", limit: 1,   default: -1
    t.integer  "pickup_time", limit: 1
    t.string   "location",    limit: 200
    t.string   "website",     limit: 512
    t.string   "pickup_am",   limit: 2
    t.string   "pickup_day",  limit: 10
    t.integer  "open_time_1", limit: 1
    t.string   "open_am_1",   limit: 2
    t.integer  "open_time_2", limit: 1
    t.string   "open_am_2",   limit: 2
    t.float    "lat"
    t.float    "lng"
  end

  create_table "members", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "general_location"
    t.string   "full_name"
    t.string   "slogan"
    t.integer  "plays_basketball",             default: -1
    t.integer  "skill_level",                  default: -1
    t.integer  "position",                     default: -1
    t.integer  "organized",                    default: -1
    t.string   "favorite_player"
    t.string   "about",            limit: 500
    t.integer  "nationality",                  default: -1
    t.date     "birthdate"
    t.integer  "height"
    t.integer  "weight"
    t.string   "photo"
  end

  add_index "members", ["email"], name: "index_members_on_email", unique: true
  add_index "members", ["full_name"], name: "index_members_on_full_name"
  add_index "members", ["remember_token"], name: "index_members_on_remember_token"

  create_table "reviews", force: true do |t|
    t.string   "content"
    t.integer  "member_id"
    t.integer  "court_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["member_id", "created_at"], name: "index_reviews_on_member_id_and_created_at"

end
