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

ActiveRecord::Schema.define(version: 20140810174132) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "athletes", force: true do |t|
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
    t.string   "nickname"
    t.date     "dob"
    t.integer  "gradyear"
    t.boolean  "active"
    t.float    "height"
    t.float    "weight"
    t.string   "email"
    t.string   "twitter"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "athletes_teams", force: true do |t|
    t.integer  "athlete_id"
    t.integer  "team_id"
    t.boolean  "captain"
    t.string   "jerseynumber"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coaches", force: true do |t|
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
    t.string   "nickname"
    t.boolean  "active"
    t.string   "email"
    t.string   "twitter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coaches_teams", force: true do |t|
    t.integer  "team_id"
    t.integer  "coach_id"
    t.boolean  "headcoach"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coaches_teams", ["coach_id", "team_id"], name: "index_coaches_teams_on_coach_id_and_team_id", unique: true, using: :btree

  create_table "sports", force: true do |t|
    t.string   "name"
    t.string   "imageurl"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sports_venues", force: true do |t|
    t.integer  "sport_id"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sports_venues", ["sport_id", "venue_id"], name: "index_sports_venues_on_sport_id_and_venue_id", unique: true, using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.boolean  "active"
    t.string   "url"
    t.string   "twitter"
    t.string   "gender"
    t.boolean  "varsity"
    t.string   "season"
    t.integer  "sport_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "googlemapsurl"
    t.string   "phone"
    t.string   "url"
    t.string   "twitter"
    t.string   "latlong"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
