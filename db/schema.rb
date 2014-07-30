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

ActiveRecord::Schema.define(:version => 20130826150205) do

  create_table "admin_actions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "admin_id"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "daily_pings", :force => true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "scores", :force => true do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.integer  "points"
    t.boolean  "approved",       :default => true
    t.integer  "admin_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "admin_override"
    t.date     "day"
  end

  add_index "scores", ["admin_id"], :name => "index_scores_on_admin_id"
  add_index "scores", ["task_id"], :name => "index_scores_on_task_id"
  add_index "scores", ["user_id"], :name => "index_scores_on_user_id"

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "value"
    t.date     "starts_on"
    t.date     "ends_on"
    t.string   "category"
    t.boolean  "milestone"
    t.integer  "bonus"
    t.text     "solution"
    t.string   "token"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "icon"
    t.text     "feedback"
    t.boolean  "pyramid"
    t.integer  "position"
  end

  create_table "tutorials", :force => true do |t|
    t.text     "youtube_embed"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "eid"
    t.string   "name"
    t.string   "email"
    t.boolean  "admin",                         :default => false
    t.boolean  "freeze_points",                 :default => false
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.integer  "score"
    t.integer  "score_be_there"
    t.integer  "score_solve_this"
    t.integer  "score_get_schooled"
    t.integer  "score_find_someone"
    t.integer  "score_play_the_book"
    t.boolean  "accepted_terms_and_conditions"
  end

  add_index "users", ["score"], :name => "index_users_on_score"
  add_index "users", ["score_be_there"], :name => "index_users_on_score_attendance"
  add_index "users", ["score_find_someone"], :name => "index_users_on_score_cooperation"
  add_index "users", ["score_get_schooled"], :name => "index_users_on_score_crosscurricular"
  add_index "users", ["score_play_the_book"], :name => "index_users_on_score_story"
  add_index "users", ["score_solve_this"], :name => "index_users_on_score_puzzle"

end
