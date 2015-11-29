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

ActiveRecord::Schema.define(version: 20151129163956) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "messages", force: :cascade do |t|
    t.integer  "ride_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "type"
    t.json     "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ride_availabilities", force: :cascade do |t|
    t.integer  "user_id",                     null: false
    t.integer  "availability_type",           null: false
    t.date     "date",                        null: false
    t.integer  "period",                      null: false
    t.text     "starting_location_address"
    t.float    "starting_location_latitude"
    t.float    "starting_location_longitude"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "available_places_in_car"
  end

  create_table "rides", force: :cascade do |t|
    t.integer  "status"
    t.integer  "giver_availability_id"
    t.integer  "receiver_availability_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "user_id",    null: false
    t.string   "token",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                               null: false
    t.string   "email",                              null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "password_digest"
    t.integer  "ride_intention",         default: 0, null: false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
