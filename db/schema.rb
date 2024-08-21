# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_08_21_193845) do
  create_table "addresses", force: :cascade do |t|
    t.string "street_address"
    t.string "landmark"
    t.string "city"
    t.string "state"
    t.string "country"
    t.integer "pincode"
    t.string "addressable_type", null: false
    t.integer "addressable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
  end

  create_table "items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "sku_id", null: false
    t.integer "quantity"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_items_on_order_id"
    t.index ["sku_id"], name: "index_items_on_sku_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id", null: false
    t.float "total_amount"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "skus", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "price"
    t.integer "quantity"
    t.boolean "is_otc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_skus_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "type"
    t.string "email"
    t.string "phonenumber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "items", "orders"
  add_foreign_key "items", "skus"
  add_foreign_key "orders", "users"
end
