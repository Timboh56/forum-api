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

ActiveRecord::Schema.define(version: 20160518013232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text     "text"
    t.string   "title"
    t.integer  "question_id"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "comments_count", default: 0
    t.integer  "votes_count",    default: 0
  end

  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "api_keys", force: :cascade do |t|
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "api_keys", ["token"], name: "index_api_keys_on_token", using: :btree

  create_table "badges", force: :cascade do |t|
    t.string   "name"
    t.integer  "rank"
    t.integer  "required_points"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "color_hex"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "bookmarkable_id"
    t.string   "bookmarkable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "bookmarks", ["bookmarkable_id"], name: "index_bookmarks_on_bookmarkable_id", using: :btree
  add_index "bookmarks", ["user_id"], name: "index_bookmarks_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "text"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "anonymous",        default: false
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["text"], name: "index_comments_on_text", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "organizations", ["created_at"], name: "index_organizations_on_created_at", using: :btree
  add_index "organizations", ["name"], name: "index_organizations_on_name", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "comments_count",         default: 0
    t.integer  "votes_count",            default: 0
    t.integer  "view_count",             default: 0
    t.integer  "answers_count",          default: 0
    t.string   "last_answerer_username"
    t.integer  "bookmarks_count",        default: 0
    t.integer  "activity_count",         default: 0
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree
  add_index "questions", ["view_count"], name: "index_questions_on_view_count", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tag_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "text"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "taggings_count", default: 0
  end

  add_index "tags", ["text"], name: "index_tags_on_text", using: :btree

  create_table "user_badges", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "badge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_stats", force: :cascade do |t|
    t.integer  "activity_count",  default: 0
    t.integer  "login_attempts",  default: 0
    t.integer  "questions_count", default: 0
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "user_stats", ["activity_count"], name: "index_user_stats_on_activity_count", using: :btree
  add_index "user_stats", ["user_id"], name: "index_user_stats_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.integer  "organization_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "votable_id"
    t.string   "votable_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree
  add_index "votes", ["votable_id"], name: "index_votes_on_votable_id", using: :btree
  add_index "votes", ["votable_type"], name: "index_votes_on_votable_type", using: :btree

end
