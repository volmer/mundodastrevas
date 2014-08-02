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

ActiveRecord::Schema.define(version: 20140802165840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "unaccent"

  create_table "bootsy_image_galleries", force: true do |t|
    t.integer  "bootsy_resource_id"
    t.string   "bootsy_resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: true do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", force: true do |t|
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

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "raddar_external_accounts", force: true do |t|
    t.string   "provider"
    t.string   "token"
    t.string   "secret"
    t.string   "name"
    t.string   "url"
    t.string   "email"
    t.string   "uid"
    t.boolean  "verified"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raddar_external_accounts", ["name", "provider"], name: "index_raddar_external_accounts_on_name_and_provider", unique: true, using: :btree
  add_index "raddar_external_accounts", ["token", "provider"], name: "index_raddar_external_accounts_on_token_and_provider", unique: true, using: :btree
  add_index "raddar_external_accounts", ["uid", "provider"], name: "index_raddar_external_accounts_on_uid_and_provider", unique: true, using: :btree
  add_index "raddar_external_accounts", ["url", "provider"], name: "index_raddar_external_accounts_on_url_and_provider", unique: true, using: :btree
  add_index "raddar_external_accounts", ["user_id", "provider"], name: "index_raddar_external_accounts_on_user_id_and_provider", unique: true, using: :btree
  add_index "raddar_external_accounts", ["user_id"], name: "index_raddar_external_accounts_on_user_id", using: :btree

  create_table "raddar_followerships", force: true do |t|
    t.integer  "user_id"
    t.integer  "followable_id"
    t.string   "followable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raddar_followerships", ["followable_id", "followable_type"], name: "index_raddar_followerships_on_followable_id_and_followable_type", using: :btree
  add_index "raddar_followerships", ["user_id", "followable_id", "followable_type"], name: "index_raddar_followerships_on_user_and_followable", unique: true, using: :btree
  add_index "raddar_followerships", ["user_id"], name: "index_raddar_followerships_on_user_id", using: :btree

  create_table "raddar_forums_forums", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "universe_id"
  end

  add_index "raddar_forums_forums", ["slug"], name: "index_raddar_forums_forums_on_slug", unique: true, using: :btree
  add_index "raddar_forums_forums", ["universe_id"], name: "index_raddar_forums_forums_on_universe_id", using: :btree

  create_table "raddar_forums_posts", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raddar_forums_posts", ["topic_id"], name: "index_raddar_forums_posts_on_topic_id", using: :btree
  add_index "raddar_forums_posts", ["user_id"], name: "index_raddar_forums_posts_on_user_id", using: :btree

  create_table "raddar_forums_topics", force: true do |t|
    t.string   "name"
    t.integer  "views",      default: 0
    t.integer  "forum_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raddar_forums_topics", ["forum_id"], name: "index_raddar_forums_topics_on_forum_id", using: :btree
  add_index "raddar_forums_topics", ["user_id"], name: "index_raddar_forums_topics_on_user_id", using: :btree

  create_table "raddar_messages", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.boolean  "read",         default: false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raddar_messages", ["recipient_id"], name: "index_raddar_messages_on_recipient_id", using: :btree
  add_index "raddar_messages", ["sender_id"], name: "index_raddar_messages_on_sender_id", using: :btree

  create_table "raddar_notifications", force: true do |t|
    t.string   "event"
    t.boolean  "unread",          default: true
    t.integer  "user_id"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raddar_notifications", ["notifiable_id", "notifiable_type"], name: "index_raddar_notifications_on_notifiable_id_and_notifiable_type", using: :btree
  add_index "raddar_notifications", ["user_id"], name: "index_raddar_notifications_on_user_id", using: :btree

  create_table "raddar_pages", force: true do |t|
    t.text     "content"
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raddar_pages", ["slug"], name: "index_raddar_pages_on_slug", unique: true, using: :btree

  create_table "raddar_reviews", force: true do |t|
    t.integer  "user_id"
    t.string   "value"
    t.integer  "reviewable_id"
    t.string   "reviewable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raddar_reviews", ["reviewable_id", "reviewable_type"], name: "index_raddar_reviews_reviewable", using: :btree
  add_index "raddar_reviews", ["user_id", "reviewable_id", "reviewable_type"], name: "index_raddar_reviews_unique_user", unique: true, using: :btree
  add_index "raddar_reviews", ["user_id"], name: "index_raddar_reviews_on_user_id", using: :btree

  create_table "raddar_roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raddar_roles", ["name"], name: "index_raddar_roles_on_name", unique: true, using: :btree

  create_table "raddar_roles_users", id: false, force: true do |t|
    t.integer "role_id", null: false
    t.integer "user_id", null: false
  end

  add_index "raddar_roles_users", ["role_id", "user_id"], name: "index_raddar_roles_users_on_role_id_and_user_id", using: :btree
  add_index "raddar_roles_users", ["user_id", "role_id"], name: "index_raddar_roles_users_on_user_id_and_role_id", using: :btree

  create_table "raddar_taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raddar_taggings", ["tag_id", "taggable_id", "taggable_type"], name: "index_raddar_taggings_unique_tag", unique: true, using: :btree
  add_index "raddar_taggings", ["tag_id"], name: "index_raddar_taggings_on_tag_id", using: :btree
  add_index "raddar_taggings", ["taggable_id", "taggable_type"], name: "index_raddar_taggins_taggable", using: :btree

  create_table "raddar_tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raddar_tags", ["name"], name: "index_raddar_tags_on_name", unique: true, using: :btree

  create_table "raddar_users", force: true do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "location"
    t.date     "birthday"
    t.string   "gender"
    t.text     "bio"
    t.string   "state",                  default: "active"
    t.string   "avatar"
    t.hstore   "privacy"
    t.hstore   "email_preferences"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_salt"
  end

  add_index "raddar_users", ["confirmation_token"], name: "index_raddar_users_on_confirmation_token", unique: true, using: :btree
  add_index "raddar_users", ["email"], name: "index_raddar_users_on_email", unique: true, using: :btree
  add_index "raddar_users", ["name"], name: "index_raddar_users_on_name", unique: true, using: :btree
  add_index "raddar_users", ["reset_password_token"], name: "index_raddar_users_on_reset_password_token", unique: true, using: :btree

  create_table "raddar_watches", force: true do |t|
    t.integer  "user_id"
    t.integer  "watchable_id"
    t.string   "watchable_type"
    t.boolean  "active",         default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raddar_watches", ["user_id", "watchable_id", "watchable_type"], name: "index_raddar_watches_unique_user", unique: true, using: :btree
  add_index "raddar_watches", ["user_id"], name: "index_raddar_watches_on_user_id", using: :btree
  add_index "raddar_watches", ["watchable_id", "watchable_type"], name: "index_raddar_watches_watchable", using: :btree

  create_table "raddar_zines_comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raddar_zines_comments", ["post_id"], name: "index_raddar_zines_comments_on_post_id", using: :btree
  add_index "raddar_zines_comments", ["user_id"], name: "index_raddar_zines_comments_on_user_id", using: :btree

  create_table "raddar_zines_posts", force: true do |t|
    t.integer  "zine_id"
    t.text     "content"
    t.string   "image"
    t.string   "name"
    t.integer  "views",      default: 0
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "raddar_zines_posts", ["slug"], name: "index_raddar_zines_posts_on_slug", unique: true, using: :btree
  add_index "raddar_zines_posts", ["user_id"], name: "index_raddar_zines_posts_on_user_id", using: :btree
  add_index "raddar_zines_posts", ["zine_id"], name: "index_raddar_zines_posts_on_zine_id", using: :btree

  create_table "raddar_zines_zines", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.text     "description"
    t.boolean  "starred",     default: false
    t.string   "image"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "universe_id"
  end

  add_index "raddar_zines_zines", ["slug"], name: "index_raddar_zines_zines_on_slug", unique: true, using: :btree
  add_index "raddar_zines_zines", ["universe_id"], name: "index_raddar_zines_zines_on_universe_id", using: :btree
  add_index "raddar_zines_zines", ["user_id"], name: "index_raddar_zines_zines_on_user_id", using: :btree

  create_table "ranks", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "universe_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ranks", ["universe_id"], name: "index_ranks_on_universe_id", using: :btree
  add_index "ranks", ["value", "universe_id"], name: "index_ranks_on_value_and_universe_id", unique: true, using: :btree
  add_index "ranks", ["value"], name: "index_ranks_on_value", using: :btree

  create_table "settings", force: true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["key"], name: "index_settings_on_key", unique: true, using: :btree

  create_table "universes", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "slug"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "universes", ["slug"], name: "index_universes_on_slug", unique: true, using: :btree

end
