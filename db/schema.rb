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

ActiveRecord::Schema.define(version: 20140819211941) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brochure_racks", force: true do |t|
    t.string   "name"
    t.integer  "number_of_rows"
    t.integer  "number_of_columns"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "brochure_racks", ["name"], name: "index_brochure_racks_on_name", unique: true, using: :btree

  create_table "clients", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["name"], name: "index_clients_on_name", unique: true, using: :btree

  create_table "placements", force: true do |t|
    t.integer  "brochure_rack_id", null: false
    t.integer  "takeaway_id",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "placements", ["brochure_rack_id"], name: "index_placements_on_brochure_rack_id", using: :btree
  add_index "placements", ["takeaway_id"], name: "index_placements_on_takeaway_id", using: :btree

  create_table "stockings", force: true do |t|
    t.date     "stocked_on",   null: false
    t.integer  "placement_id", null: false
    t.integer  "quantity",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stockings", ["placement_id"], name: "index_stockings_on_placement_id", using: :btree

  create_table "takeaways", force: true do |t|
    t.string   "name",       null: false
    t.integer  "client_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "takeaways", ["client_id"], name: "index_takeaways_on_client_id", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
