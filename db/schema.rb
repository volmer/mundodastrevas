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

ActiveRecord::Schema.define(version: 20131204001625) do

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
    t.string   "token"
    t.string   "item_path"
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
  end

  add_index "raddar_users", ["confirmation_token"], name: "index_raddar_users_on_confirmation_token", unique: true, using: :btree
  add_index "raddar_users", ["email"], name: "index_raddar_users_on_email", unique: true, using: :btree
  add_index "raddar_users", ["name"], name: "index_raddar_users_on_name", unique: true, using: :btree
  add_index "raddar_users", ["reset_password_token"], name: "index_raddar_users_on_reset_password_token", unique: true, using: :btree

end
