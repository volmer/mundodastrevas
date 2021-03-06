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

ActiveRecord::Schema.define(version: 20160430175340) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "unaccent"

  create_table "activities", force: :cascade do |t|
    t.integer  "subject_id"
    t.string   "subject_type", limit: 255
    t.integer  "user_id"
    t.string   "key",          limit: 255
    t.hstore   "parameters"
    t.string   "privacy",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["subject_id", "subject_type"], name: "index_activities_on_subject_id_and_subject_type", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "bootsy_image_galleries", force: :cascade do |t|
    t.integer  "bootsy_resource_id"
    t.string   "bootsy_resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: :cascade do |t|
    t.string   "image_file",       limit: 255
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "external_accounts", force: :cascade do |t|
    t.string   "provider",   limit: 255
    t.string   "token",      limit: 255
    t.string   "secret",     limit: 255
    t.string   "name",       limit: 255
    t.string   "url",        limit: 255
    t.string   "email",      limit: 255
    t.string   "uid",        limit: 255
    t.boolean  "verified"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "external_accounts", ["name", "provider"], name: "index_external_accounts_on_name_and_provider", unique: true, using: :btree
  add_index "external_accounts", ["token", "provider"], name: "index_external_accounts_on_token_and_provider", unique: true, using: :btree
  add_index "external_accounts", ["uid", "provider"], name: "index_external_accounts_on_uid_and_provider", unique: true, using: :btree
  add_index "external_accounts", ["url", "provider"], name: "index_external_accounts_on_url_and_provider", unique: true, using: :btree
  add_index "external_accounts", ["user_id", "provider"], name: "index_external_accounts_on_user_id_and_provider", unique: true, using: :btree
  add_index "external_accounts", ["user_id"], name: "index_external_accounts_on_user_id", using: :btree

  create_table "followerships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "followable_id"
    t.string   "followable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "followerships", ["followable_id", "followable_type"], name: "index_followerships_on_followable_id_and_followable_type", using: :btree
  add_index "followerships", ["user_id", "followable_id", "followable_type"], name: "index_raddar_followerships_on_user_and_followable", unique: true, using: :btree
  add_index "followerships", ["user_id"], name: "index_followerships_on_user_id", using: :btree

  create_table "forum_posts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forum_posts", ["topic_id"], name: "index_forum_posts_on_topic_id", using: :btree
  add_index "forum_posts", ["user_id"], name: "index_forum_posts_on_user_id", using: :btree

  create_table "forums", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",        limit: 255
    t.integer  "universe_id"
  end

  add_index "forums", ["slug"], name: "index_forums_on_slug", unique: true, using: :btree
  add_index "forums", ["universe_id"], name: "index_forums_on_universe_id", using: :btree

  create_table "levels", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "universe_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "levels", ["universe_id"], name: "index_levels_on_universe_id", using: :btree
  add_index "levels", ["user_id", "universe_id"], name: "index_levels_on_user_id_and_universe_id", unique: true, using: :btree
  add_index "levels", ["user_id"], name: "index_levels_on_user_id", using: :btree
  add_index "levels", ["value"], name: "index_levels_on_value", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.boolean  "read",         default: false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.string   "event",           limit: 255
    t.boolean  "unread",                      default: true
    t.integer  "user_id"
    t.integer  "notifiable_id"
    t.string   "notifiable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["notifiable_id", "notifiable_type"], name: "index_notifications_on_notifiable_id_and_notifiable_type", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.text     "content"
    t.string   "title",      limit: 255
    t.string   "slug",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "zine_id"
    t.text     "content"
    t.string   "image",      limit: 255
    t.string   "name",       limit: 255
    t.integer  "views",                  default: 0
    t.string   "slug",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree
  add_index "posts", ["zine_id"], name: "index_posts_on_zine_id", using: :btree

  create_table "ranks", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.integer  "universe_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ranks", ["universe_id"], name: "index_ranks_on_universe_id", using: :btree
  add_index "ranks", ["value", "universe_id"], name: "index_ranks_on_value_and_universe_id", unique: true, using: :btree
  add_index "ranks", ["value"], name: "index_ranks_on_value", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "value",           limit: 255
    t.integer  "reviewable_id"
    t.string   "reviewable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["reviewable_id", "reviewable_type"], name: "index_raddar_reviews_reviewable", using: :btree
  add_index "reviews", ["user_id", "reviewable_id", "reviewable_type"], name: "index_raddar_reviews_unique_user", unique: true, using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], name: "index_roles_on_name", unique: true, using: :btree

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id", null: false
    t.integer "user_id", null: false
  end

  add_index "roles_users", ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id", using: :btree
  add_index "roles_users", ["user_id", "role_id"], name: "index_roles_users_on_user_id_and_role_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type"], name: "index_raddar_taggings_unique_tag", unique: true, using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type"], name: "index_raddar_taggins_taggable", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "views",                  default: 0
    t.integer  "forum_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["forum_id"], name: "index_topics_on_forum_id", using: :btree
  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "universes", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.string   "slug",        limit: 255
    t.string   "image",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "universes", ["slug"], name: "index_universes_on_slug", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",       null: false
    t.string   "encrypted_password",     limit: 255, default: "",       null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "name",                   limit: 255
    t.string   "location",               limit: 255
    t.date     "birthday"
    t.string   "gender",                 limit: 255
    t.text     "bio"
    t.string   "state",                  limit: 255, default: "active"
    t.string   "avatar",                 limit: 255
    t.hstore   "privacy"
    t.hstore   "email_preferences"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "watches", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "watchable_id"
    t.string   "watchable_type", limit: 255
    t.boolean  "active",                     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "watches", ["user_id", "watchable_id", "watchable_type"], name: "index_raddar_watches_unique_user", unique: true, using: :btree
  add_index "watches", ["user_id"], name: "index_watches_on_user_id", using: :btree
  add_index "watches", ["watchable_id", "watchable_type"], name: "index_raddar_watches_watchable", using: :btree

  create_table "zines", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "user_id"
    t.text     "description"
    t.string   "image",        limit: 255
    t.string   "slug",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "universe_id"
    t.datetime "last_post_at"
  end

  add_index "zines", ["slug"], name: "index_zines_on_slug", unique: true, using: :btree
  add_index "zines", ["universe_id"], name: "index_zines_on_universe_id", using: :btree
  add_index "zines", ["user_id"], name: "index_zines_on_user_id", using: :btree

end
