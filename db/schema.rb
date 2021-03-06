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

ActiveRecord::Schema.define(version: 20160120040146) do

  create_table "assignments", force: :cascade do |t|
    t.string   "name"
    t.boolean  "removed",    default: false
    t.date     "due"
    t.integer  "creator_id"
    t.integer  "remover_id"
    t.integer  "course_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.boolean  "removed",    default: false
    t.integer  "creator_id"
    t.integer  "remover_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "problems", force: :cascade do |t|
    t.integer  "number"
    t.integer  "part"
    t.boolean  "removed",          default: false
    t.text     "source"
    t.text     "instructions"
    t.text     "generated_source"
    t.integer  "creator_id"
    t.integer  "remover_id"
    t.integer  "assignment_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "mode",             default: "text/x-python"
  end

  create_table "templates", force: :cascade do |t|
    t.boolean  "removed",      default: false
    t.text     "code"
    t.text     "instructions"
    t.string   "mode"
    t.string   "name"
    t.integer  "creator_id"
    t.integer  "remover_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "test_cases", force: :cascade do |t|
    t.string   "input"
    t.string   "output"
    t.boolean  "removed",    default: false
    t.integer  "creator_id"
    t.integer  "remover_id"
    t.integer  "problem_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "test_cases_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "test_case_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean  "admin",                  default: false
    t.string   "name"
    t.string   "image"
    t.string   "provider"
    t.string   "uid"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
