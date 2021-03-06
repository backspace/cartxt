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

ActiveRecord::Schema.define(version: 20141118162018) do

  create_table "bookings", force: true do |t|
    t.integer  "car_id"
    t.integer  "sharer_id"
    t.datetime "begins_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  add_index "bookings", ["car_id"], name: "index_bookings_on_car_id"
  add_index "bookings", ["sharer_id"], name: "index_bookings_on_sharer_id"

  create_table "borrowings", force: true do |t|
    t.integer  "car_id"
    t.integer  "sharer_id"
    t.integer  "initial"
    t.integer  "final"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "rate"
    t.integer  "booking_id"
  end

  add_index "borrowings", ["booking_id"], name: "index_borrowings_on_booking_id"

  create_table "cars", force: true do |t|
    t.integer  "odometer_reading"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "number"
    t.float    "rate"
    t.string   "location_information"
    t.string   "lockbox_information"
    t.string   "description"
  end

  create_table "responses", force: true do |t|
    t.string   "name"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sharers", force: true do |t|
    t.string   "number"
    t.string   "name"
    t.string   "status"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "balance",            default: 0.0
    t.boolean  "notify_of_bookings"
    t.boolean  "receive_copies"
    t.float    "pending_payments",   default: 0.0
    t.string   "email"
  end

  create_table "transactions", force: true do |t|
    t.float    "amount"
    t.integer  "origin_id"
    t.string   "origin_type"
    t.integer  "sharer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["origin_id", "origin_type"], name: "index_transactions_on_origin_id_and_origin_type"
  add_index "transactions", ["sharer_id"], name: "index_transactions_on_sharer_id"

  create_table "txts", force: true do |t|
    t.string   "from"
    t.string   "to"
    t.text     "body",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "originator_id"
  end

  add_index "txts", ["originator_id"], name: "index_txts_on_originator_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "role"
    t.boolean  "approved"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
