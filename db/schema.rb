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

ActiveRecord::Schema.define(version: 20151114001857) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "expenditures", force: true do |t|
    t.integer  "ammount"
    t.integer  "status"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "expense_type_id"
    t.integer  "month_id"
  end

  add_index "expenditures", ["expense_type_id"], name: "index_expenditures_on_expense_type_id", using: :btree
  add_index "expenditures", ["month_id"], name: "index_expenditures_on_month_id", using: :btree
  add_index "expenditures", ["user_id"], name: "index_expenditures_on_user_id", using: :btree

  create_table "expense_types", force: true do |t|
    t.string   "name"
    t.boolean  "is_bill"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_fixed_cost", default: true
  end

  create_table "is_user_in_houses", force: true do |t|
    t.integer  "day"
    t.boolean  "was_at_home"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "month_id"
    t.integer  "user_id"
  end

  add_index "is_user_in_houses", ["month_id"], name: "index_is_user_in_houses_on_month_id", using: :btree
  add_index "is_user_in_houses", ["user_id"], name: "index_is_user_in_houses_on_user_id", using: :btree

  create_table "months", force: true do |t|
    t.integer  "month"
    t.integer  "year"
    t.boolean  "payed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
