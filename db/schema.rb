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

ActiveRecord::Schema.define(:version => 20130627103710) do

  create_table "article_categories", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "desctiption"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "articles", :force => true do |t|
    t.string   "title",      :null => false
    t.text     "annotation"
    t.text     "content",    :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "articles", ["user_id"], :name => "index_articles_on_user_id"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clubs", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "short_name", :null => false
    t.string   "shortcut",   :null => false
    t.string   "logo"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.string   "title"
    t.text     "content",    :null => false
    t.integer  "user_id",    :null => false
    t.integer  "article_id"
    t.integer  "comment_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["article_id"], :name => "index_comments_on_article_id"
  add_index "comments", ["comment_id"], :name => "index_comments_on_comment_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "marks", :force => true do |t|
    t.integer  "article_id", :null => false
    t.integer  "user_id",    :null => false
    t.integer  "value",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "marks", ["article_id"], :name => "index_marks_on_article_id"
  add_index "marks", ["user_id"], :name => "index_marks_on_user_id"

  create_table "players", :force => true do |t|
    t.string   "first_name",  :null => false
    t.string   "second_name", :null => false
    t.string   "nick_name"
    t.datetime "birthday"
    t.text     "note"
    t.string   "icon"
    t.integer  "team_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "players", ["team_id"], :name => "index_players_on_team_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "shortcut"
    t.integer  "level",      :default => 0, :null => false
    t.string   "logo"
    t.integer  "club_id",                   :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "teams", ["club_id"], :name => "index_teams_on_club_id"

  create_table "users", :force => true do |t|
    t.string   "username",                                                           :null => false
    t.string   "email",                                                              :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.text     "role",                            :default => "---\n- :commenter\n", :null => false
    t.string   "first_name"
    t.string   "second_name"
    t.boolean  "blocked",                         :default => false,                 :null => false
    t.datetime "block_expires_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
  end

end
