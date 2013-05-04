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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130504124939) do

  create_table "competitions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "divisions", :force => true do |t|
    t.string   "name"
    t.integer  "sex"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "season_id"
  end

  create_table "invoices", :force => true do |t|
    t.text     "notes"
    t.integer  "amount"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "player_id"
    t.integer  "season_id"
    t.integer  "outstanding"
  end

  create_table "payments", :force => true do |t|
    t.integer  "amount"
    t.integer  "method"
    t.text     "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "invoice_id"
  end

  create_table "players", :force => true do |t|
    t.string   "name_family"
    t.string   "name_given"
    t.integer  "student_number"
    t.string   "email"
    t.date     "date_of_birth"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "sex"
    t.integer  "number"
  end

  create_table "players_teams", :id => false, :force => true do |t|
    t.integer "player_id"
    t.integer "team_id"
  end

  create_table "seasons", :force => true do |t|
    t.string   "name"
    t.date     "date_start"
    t.integer  "cost"
    t.integer  "cost_student"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "competition_id"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "division_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
