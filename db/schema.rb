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

ActiveRecord::Schema.define(:version => 20131026122019) do

  create_table "blog_comments", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "email",      :null => false
    t.string   "website"
    t.text     "body",       :null => false
    t.integer  "post_id",    :null => false
    t.string   "state"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "blog_comments", ["post_id"], :name => "index_blog_comments_on_post_id"

  create_table "blog_posts", :force => true do |t|
    t.string   "title",                         :null => false
    t.text     "body",                          :null => false
    t.integer  "blogger_id"
    t.string   "blogger_type"
    t.integer  "comments_count", :default => 0, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "blog_posts", ["blogger_type", "blogger_id"], :name => "index_blog_posts_on_blogger_type_and_blogger_id"

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

  create_table "monologue_posts", :force => true do |t|
    t.integer  "posts_revision_id"
    t.boolean  "published"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "monologue_posts_revisions", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "url"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "published_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "monologue_posts_revisions", ["id"], :name => "index_monologue_posts_revisions_on_id", :unique => true
  add_index "monologue_posts_revisions", ["post_id"], :name => "index_monologue_posts_revisions_on_post_id"
  add_index "monologue_posts_revisions", ["published_at"], :name => "index_monologue_posts_revisions_on_published_at"
  add_index "monologue_posts_revisions", ["url"], :name => "index_monologue_posts_revisions_on_url"

  create_table "monologue_taggings", :force => true do |t|
    t.integer "post_id"
    t.integer "tag_id"
  end

  add_index "monologue_taggings", ["post_id"], :name => "index_monologue_taggings_on_post_id"
  add_index "monologue_taggings", ["tag_id"], :name => "index_monologue_taggings_on_tag_id"

  create_table "monologue_tags", :force => true do |t|
    t.string "name"
  end

  add_index "monologue_tags", ["name"], :name => "index_monologue_tags_on_name"

  create_table "monologue_users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "players", :force => true do |t|
    t.string   "name_family"
    t.string   "name_given"
    t.integer  "student_number"
    t.string   "email"
    t.date     "date_of_birth"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "sex"
    t.integer  "number"
    t.boolean  "student_ceased"
    t.boolean  "active_ceased",  :default => false
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
    t.date     "date_end"
  end

  create_table "spare_uniforms", :force => true do |t|
    t.integer  "number"
    t.string   "size"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "sex"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "division_id"
  end

  create_table "transaction_categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "transactions", :force => true do |t|
    t.boolean  "credit"
    t.string   "method"
    t.decimal  "amount"
    t.text     "notes"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "invoice_id"
    t.integer  "category_id"
    t.date     "paid_at"
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
