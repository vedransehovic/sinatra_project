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

ActiveRecord::Schema.define(version: 20200709150913) do

  create_table "deliveries", force: :cascade do |t|
    t.string   "task"
    t.datetime "date"
    t.integer  "recepients_id"
    t.integer  "volunteer_id"
  end

  create_table "recepients", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "municipality"
    t.string "phone"
  end

  create_table "volunteers", force: :cascade do |t|
    t.string  "name"
    t.string  "phone"
    t.boolean "is_admin"
  end

end
