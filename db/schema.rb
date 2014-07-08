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

ActiveRecord::Schema.define(version: 20140708060150) do

  create_table "courts", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "general_location"
    t.string   "display_name"
    t.string   "full_name"
    t.string   "slogan"
    t.integer  "plays_basketball",             default: -1
    t.integer  "skill_level",                  default: -1
    t.integer  "position",                     default: -1
    t.integer  "organized",                    default: -1
    t.string   "favorite_player"
    t.string   "about",            limit: 500
  end

  add_index "members", ["display_name"], name: "index_members_on_display_name"
  add_index "members", ["email"], name: "index_members_on_email", unique: true
  add_index "members", ["full_name"], name: "index_members_on_full_name"
  add_index "members", ["remember_token"], name: "index_members_on_remember_token"

end
