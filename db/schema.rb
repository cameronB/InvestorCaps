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

ActiveRecord::Schema.define(:version => 20130215234826) do

  create_table "c_relationships", :force => true do |t|
    t.integer  "c_follower_id"
    t.integer  "c_followed_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "c_relationships", ["c_followed_id"], :name => "index_c_relationships_on_c_followed_id"
  add_index "c_relationships", ["c_follower_id", "c_followed_id"], :name => "index_c_relationships_on_c_follower_id_and_c_followed_id", :unique => true
  add_index "c_relationships", ["c_follower_id"], :name => "index_c_relationships_on_c_follower_id"

  create_table "comment_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "up"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "symbol"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "companies", ["symbol"], :name => "index_companies_on_symbol", :unique => true

  create_table "post_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "up"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.string   "symbol"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
    t.string   "content"
  end

  create_table "s_relationships", :force => true do |t|
    t.integer  "s_follower_id"
    t.integer  "s_followed_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "s_relationships", ["s_followed_id"], :name => "index_s_relationships_on_s_followed_id"
  add_index "s_relationships", ["s_follower_id", "s_followed_id"], :name => "index_s_relationships_on_s_follower_id_and_s_followed_id", :unique => true
  add_index "s_relationships", ["s_follower_id"], :name => "index_s_relationships_on_s_follower_id"

  create_table "users", :force => true do |t|
    t.string   "username"
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
