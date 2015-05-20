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

ActiveRecord::Schema.define(version: 20150520203308) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "images", force: :cascade do |t|
    t.text     "url"
    t.integer  "land_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "images", ["land_id"], name: "index_images_on_land_id", using: :btree

  create_table "lands", force: :cascade do |t|
    t.string   "heading"
    t.text     "body"
    t.decimal  "price"
    t.string   "neighborhood"
    t.string   "external_url"
    t.string   "timestamp"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "bedrooms"
    t.decimal  "bathrooms"
    t.integer  "sqft"
    t.string   "cats"
    t.string   "dogs"
    t.string   "w_d_in_units"
    t.string   "street_parking"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "images", "lands"
end
