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

ActiveRecord::Schema.define(version: 20151120011808) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ads", force: :cascade do |t|
    t.string   "name"
    t.string   "imageurl"
    t.string   "clickurl"
    t.string   "adtype"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "athletes", force: :cascade do |t|
    t.string   "firstname",  limit: 255
    t.string   "middlename", limit: 255
    t.string   "lastname",   limit: 255
    t.string   "nickname",   limit: 255
    t.date     "dob"
    t.integer  "gradyear"
    t.boolean  "active"
    t.float    "height"
    t.float    "weight"
    t.string   "email",      limit: 255
    t.string   "twitter",    limit: 255
    t.string   "gender",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "athletes_teams", force: :cascade do |t|
    t.integer  "athlete_id"
    t.integer  "team_id"
    t.boolean  "captain"
    t.string   "jerseynumber", limit: 255
    t.string   "position",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banner_ads", force: :cascade do |t|
    t.string   "patron"
    t.string   "imageurl"
    t.string   "clickurl"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coaches", force: :cascade do |t|
    t.string   "firstname",  limit: 255
    t.string   "middlename", limit: 255
    t.string   "lastname",   limit: 255
    t.string   "nickname",   limit: 255
    t.boolean  "active"
    t.string   "email",      limit: 255
    t.string   "twitter",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone",      limit: 255
  end

  create_table "coaches_teams", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "coach_id"
    t.boolean  "headcoach"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coaches_teams", ["coach_id", "team_id"], name: "index_coaches_teams_on_coach_id_and_team_id", unique: true, using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "teamid"
    t.integer  "opponentid"
    t.integer  "venueid"
    t.integer  "eventduration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "eventdate",     limit: 255
    t.string   "eventtime",     limit: 255
    t.string   "eventlocation", limit: 255
    t.string   "status",        limit: 255
    t.string   "notes",         limit: 255
    t.string   "opponents",     limit: 255
    t.string   "description",   limit: 255
  end

  create_table "opponents", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "mascot",             limit: 255
    t.integer  "homevenue"
    t.boolean  "conferenceopponent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", force: :cascade do |t|
    t.string   "result",        limit: 255
    t.integer  "place"
    t.float    "teamscore"
    t.float    "opponentscore"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "notes",         limit: 255
    t.integer  "event_id"
  end

  add_index "results", ["event_id"], name: "index_results_on_event_id", using: :btree

  create_table "sports", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "imageurl",   limit: 255
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "resulttype", limit: 255
  end

  create_table "sports_venues", force: :cascade do |t|
    t.integer  "sport_id"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sports_venues", ["sport_id", "venue_id"], name: "index_sports_venues_on_sport_id_and_venue_id", unique: true, using: :btree

  create_table "sugs", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "sugurl"
    t.boolean  "active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "active"
    t.string   "url",        limit: 255
    t.string   "twitter",    limit: 255
    t.string   "gender",     limit: 255
    t.boolean  "varsity"
    t.string   "season",     limit: 255
    t.integer  "sport_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "suffix",     limit: 255
    t.string   "teampicurl", limit: 255
    t.boolean  "showgender"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: ""
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "invitation_token",       limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type",        limit: 255
    t.integer  "invitations_count",                  default: 0
    t.boolean  "admin",                              default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.text     "address"
    t.string   "googlemapsurl", limit: 255
    t.string   "phone",         limit: 255
    t.string   "url",           limit: 255
    t.string   "twitter",       limit: 255
    t.string   "latlong",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
