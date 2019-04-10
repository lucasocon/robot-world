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

ActiveRecord::Schema.define(version: 20190410010449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.decimal  "price",      precision: 10, scale: 2, default: 0.0
    t.decimal  "cost_price", precision: 10, scale: 2, default: 0.0
    t.integer  "year"
    t.string   "car_model"
    t.string   "state"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "chasses", force: :cascade do |t|
    t.integer  "car_id"
    t.string   "name"
    t.integer  "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "chasses", ["car_id"], name: "index_chasses_on_car_id", using: :btree

  create_table "computers", force: :cascade do |t|
    t.integer  "car_id"
    t.string   "name"
    t.integer  "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "computers", ["car_id"], name: "index_computers_on_car_id", using: :btree

  create_table "engines", force: :cascade do |t|
    t.integer  "car_id"
    t.string   "name"
    t.integer  "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "engines", ["car_id"], name: "index_engines_on_car_id", using: :btree

  create_table "factory_stocks", force: :cascade do |t|
    t.string   "car_model"
    t.integer  "stock",              default: 0
    t.integer  "cars_ready",         default: 0
    t.integer  "cars_with_failures", default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "failures", force: :cascade do |t|
    t.integer  "computer_id"
    t.string   "location"
    t.boolean  "is_notified", default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "failures", ["computer_id"], name: "index_failures_on_computer_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "car"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "items", ["order_id"], name: "index_items_on_order_id", using: :btree

  create_table "lasers", force: :cascade do |t|
    t.integer  "car_id"
    t.string   "name"
    t.integer  "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lasers", ["car_id"], name: "index_lasers_on_car_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "code"
    t.string   "buyer"
    t.date     "date"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "seats", force: :cascade do |t|
    t.integer  "car_id"
    t.string   "name"
    t.integer  "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "seats", ["car_id"], name: "index_seats_on_car_id", using: :btree

  create_table "store_stocks", force: :cascade do |t|
    t.string   "car_model"
    t.integer  "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wheels", force: :cascade do |t|
    t.integer  "car_id"
    t.string   "name"
    t.integer  "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "wheels", ["car_id"], name: "index_wheels_on_car_id", using: :btree

  add_foreign_key "chasses", "cars"
  add_foreign_key "computers", "cars"
  add_foreign_key "engines", "cars"
  add_foreign_key "failures", "computers"
  add_foreign_key "items", "orders"
  add_foreign_key "lasers", "cars"
  add_foreign_key "seats", "cars"
  add_foreign_key "wheels", "cars"
end
