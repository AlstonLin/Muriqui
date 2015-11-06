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

ActiveRecord::Schema.define(version: 20151106001116) do

  create_table "assignments", force: :cascade do |t|
    t.string   "name"
    t.integer  "course_id"
    t.datetime "due"
    t.integer  "creator_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "problems", force: :cascade do |t|
    t.integer  "assignment_id"
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "creator_id"
  end

  create_table "source_codes", force: :cascade do |t|
    t.string   "name"
    t.string   "attachment"
    t.integer  "owner_id"
    t.integer  "problem_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "source_codes", ["owner_id"], name: "index_source_codes_on_owner_id"
  add_index "source_codes", ["problem_id"], name: "index_source_codes_on_problem_id"

  create_table "test_cases", force: :cascade do |t|
    t.integer  "problem_id"
    t.string   "input"
    t.string   "output"
    t.boolean  "legal"
    t.integer  "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tests", force: :cascade do |t|
    t.integer  "problem_id"
    t.integer  "source_id"
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tests", ["owner_id"], name: "index_tests_on_owner_id"
  add_index "tests", ["source_id"], name: "index_tests_on_source_id"

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image"
    t.string   "token"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
