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

ActiveRecord::Schema.define(version: 20150204045802) do

  create_table "attendees", force: true do |t|
    t.integer  "event_id"
    t.integer  "court_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "court_photos", force: true do |t|
    t.string   "photo"
    t.integer  "court_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  create_table "court_videos", force: true do |t|
    t.string   "vi"
    t.integer  "court_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "court_videos", ["member_id", "created_at"], name: "index_court_videos_on_member_id_and_created_at"

  create_table "courts", force: true do |t|
    t.string   "name"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "skill_level", limit: 1,   default: -1
    t.string   "location",    limit: 200
    t.string   "website",     limit: 512
    t.integer  "open_time_1", limit: 1
    t.string   "open_am_1",   limit: 2
    t.integer  "open_time_2", limit: 1
    t.string   "open_am_2",   limit: 2
    t.float    "lat"
    t.float    "lng"
    t.integer  "main_photo"
    t.decimal  "distance"
    t.text     "details"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.integer  "court_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "details",    limit: 800
    t.datetime "start"
    t.datetime "end"
    t.float    "lat"
    t.float    "lng"
    t.integer  "main_photo"
  end

  add_index "events", ["court_id"], name: "index_events_on_court_id"
  add_index "events", ["member_id"], name: "index_events_on_member_id"

  create_table "identities", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "member_actions", force: true do |t|
    t.integer  "member_id"
    t.string   "action_text"
    t.integer  "link_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level",       default: 0, null: false
    t.string   "linkType"
  end

  add_index "member_actions", ["member_id"], name: "index_member_actions_on_member_id"

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
    t.integer  "weight"
    t.string   "photo"
    t.integer  "height_feet"
    t.integer  "height_inches"
    t.float    "lat"
    t.float    "lng"
    t.boolean  "active",                       default: true
    t.boolean  "registered"
    t.boolean  "admin"
    t.string   "verification"
    t.datetime "lastLogin"
  end

  add_index "members", ["email"], name: "index_members_on_email", unique: true
  add_index "members", ["full_name"], name: "index_members_on_full_name"
  add_index "members", ["name"], name: "index_members_on_name", unique: true
  add_index "members", ["remember_token"], name: "index_members_on_remember_token"

  create_table "pickup_attendees", force: true do |t|
    t.integer  "pickup_game_id"
    t.integer  "court_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pickup_games", force: true do |t|
    t.integer  "day"
    t.float    "time"
    t.integer  "member_id"
    t.integer  "court_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pickup_attendees_count", default: 0, null: false
  end

  add_index "pickup_games", ["court_id"], name: "index_pickup_games_on_court_id"
  add_index "pickup_games", ["day"], name: "index_pickup_games_on_day"

  create_table "reviews", force: true do |t|
    t.string   "content"
    t.integer  "member_id"
    t.integer  "court_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["court_id", "created_at"], name: "index_reviews_on_court_id_and_created_at"
  add_index "reviews", ["member_id", "created_at"], name: "index_reviews_on_member_id_and_created_at"

  create_table "video_articles", force: true do |t|
    t.string   "vi"
    t.integer  "member_id"
    t.float    "priority"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
