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

ActiveRecord::Schema.define(version: 20150314195646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "content",          null: false
    t.integer  "commentable_id",   null: false
    t.string   "commentable_type", null: false
    t.integer  "user_id",          null: false
    t.integer  "post_id",          null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "post_subs", force: :cascade do |t|
    t.integer  "post_id",    null: false
    t.integer  "sub_id",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "post_subs", ["post_id"], name: "index_post_subs_on_post_id", using: :btree
  add_index "post_subs", ["sub_id"], name: "index_post_subs_on_sub_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title",      null: false
    t.string   "url"
    t.text     "content"
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "subs", force: :cascade do |t|
    t.string   "title",       null: false
    t.text     "description"
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "subs", ["user_id"], name: "index_subs_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                           null: false
    t.string   "password_digest",                 null: false
    t.string   "session_token",                   null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["password_digest"], name: "index_users_on_password_digest", using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "value",        default: 0, null: false
    t.integer  "user_id",                  null: false
    t.integer  "votable_id",               null: false
    t.string   "votable_type",             null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "votes", ["user_id", "votable_id", "votable_type"], name: "index_votes_on_user_id_and_votable_id_and_votable_type", unique: true, using: :btree

end
