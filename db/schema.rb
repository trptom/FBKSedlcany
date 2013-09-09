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

ActiveRecord::Schema.define(:version => 20130909182346) do

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

  create_table "games", :force => true do |t|
    t.datetime "start",             :null => false
    t.integer  "home_team_id",      :null => false
    t.integer  "away_team_id",      :null => false
    t.text     "score"
    t.integer  "hall_id"
    t.integer  "organizer_id",      :null => false
    t.integer  "league_id",         :null => false
    t.integer  "season",            :null => false
    t.integer  "round"
    t.integer  "creator_id",        :null => false
    t.integer  "editor_id",         :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "cfbu_profile_data"
  end

  add_index "games", ["away_team_id"], :name => "index_games_on_away_team_id"
  add_index "games", ["creator_id"], :name => "index_games_on_creator_id"
  add_index "games", ["editor_id"], :name => "index_games_on_editor_id"
  add_index "games", ["hall_id"], :name => "index_games_on_hall_id"
  add_index "games", ["home_team_id"], :name => "index_games_on_home_team_id"
  add_index "games", ["league_id"], :name => "index_games_on_league_id"
  add_index "games", ["organizer_id"], :name => "index_games_on_organizer_id"
  add_index "games", ["season"], :name => "index_games_on_season"

  create_table "halls", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "images", :force => true do |t|
    t.string   "name",                           :null => false
    t.text     "description"
    t.string   "logical_folder", :default => "", :null => false
    t.string   "image",                          :null => false
    t.integer  "user_id",                        :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "images", ["user_id"], :name => "index_images_on_user_id"

  create_table "league_teams", :force => true do |t|
    t.integer  "league_id",       :null => false
    t.integer  "team_id",         :null => false
    t.integer  "season",          :null => false
    t.integer  "position"
    t.string   "position_string"
    t.text     "comment"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "league_teams", ["league_id"], :name => "index_league_teams_on_league_id"
  add_index "league_teams", ["team_id"], :name => "index_league_teams_on_team_id"

  create_table "leagues", :force => true do |t|
    t.string   "name",                             :null => false
    t.string   "short_name",                       :null => false
    t.string   "shortcut",                         :null => false
    t.integer  "level",             :default => 1, :null => false
    t.integer  "group",             :default => 1, :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "cfbu_profile_data"
  end

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
    t.string   "first_name",        :null => false
    t.string   "second_name",       :null => false
    t.string   "nick_name"
    t.date     "birthday"
    t.text     "note"
    t.string   "icon"
    t.integer  "team_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "cfbu_profile_data"
    t.integer  "weight"
    t.integer  "height"
    t.integer  "stick_holding"
  end

  add_index "players", ["team_id"], :name => "index_players_on_team_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "shortcut"
    t.integer  "level",             :default => 0, :null => false
    t.string   "logo"
    t.integer  "club_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "cfbu_profile_data"
  end

  add_index "teams", ["club_id"], :name => "index_teams_on_club_id"

  create_table "users", :force => true do |t|
    t.string   "username",                                                                      :null => false
    t.string   "email",                                                                         :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.text     "role",                            :default => "---\n- :commenter\n- :marker\n", :null => false
    t.string   "first_name"
    t.string   "second_name"
    t.boolean  "blocked",                         :default => false,                            :null => false
    t.datetime "block_expires_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.datetime "created_at",                                                                    :null => false
    t.datetime "updated_at",                                                                    :null => false
  end

end
