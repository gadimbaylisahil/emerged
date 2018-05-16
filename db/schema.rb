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

ActiveRecord::Schema.define(version: 2018_05_16_214954) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.integer "subject_id", null: false
    t.string "subject_type", null: false
    t.string "activity_type", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_public", default: false, null: false
    t.index ["subject_id"], name: "index_activities_on_subject_id"
    t.index ["subject_type"], name: "index_activities_on_subject_type"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "reward_id"
    t.bigint "cart_id"
    t.integer "quantity"
    t.integer "unit_price_cents", default: 0, null: false
    t.integer "total_price_cents", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "purchase_id"
    t.integer "split_purchase_id"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["reward_id"], name: "index_cart_items_on_reward_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer "total_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "status", default: "active", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chats", force: :cascade do |t|
    t.string "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "commentable_type"
    t.integer "commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "creations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.string "title"
    t.text "description"
    t.text "license"
    t.boolean "sensitive_content", default: false
    t.boolean "disable_comments", default: false
    t.bigint "user_id"
    t.bigint "number_of_views", default: 0, null: false
    t.boolean "published", default: false, null: false
    t.bigint "category_id"
    t.integer "license_id"
    t.index ["category_id"], name: "index_creations_on_category_id"
    t.index ["user_id"], name: "index_creations_on_user_id"
  end

  create_table "follows", id: :serial, force: :cascade do |t|
    t.string "followable_type", null: false
    t.integer "followable_id", null: false
    t.string "follower_type", null: false
    t.integer "follower_id", null: false
    t.boolean "blocked", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["followable_id", "followable_type"], name: "fk_followables"
    t.index ["follower_id", "follower_type"], name: "fk_follows"
  end

  create_table "licenses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "chat_id"
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "recipient_user_id", null: false
    t.integer "actor_user_id", null: false
    t.datetime "read_at"
    t.string "activity_type", null: false
    t.integer "subject_id", null: false
    t.string "subject_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "total_cents"
    t.string "status"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "cart_id"
    t.integer "seller_ids", default: [], array: true
    t.string "fullfillment_status", default: "pending", null: false
    t.index ["cart_id"], name: "index_purchases_on_cart_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "cover_photo"
    t.string "title"
    t.text "description"
    t.string "reward_type"
    t.boolean "visible", default: false, null: false
    t.boolean "charge_taxes?"
    t.bigint "category_id"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "EUR", null: false
    t.integer "shipping_cost_cents", default: 0, null: false
    t.string "shipping_cost_currency", default: "EUR", null: false
    t.index ["category_id"], name: "index_rewards_on_category_id"
    t.index ["user_id"], name: "index_rewards_on_user_id"
  end

  create_table "settings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.boolean "receive_emails_for_likes", default: true, null: false
    t.boolean "receive_emails_for_follows", default: true, null: false
    t.boolean "receive_emails_from_emerged", default: true, null: false
    t.index ["user_id"], name: "index_settings_on_user_id"
  end

  create_table "split_purchases", force: :cascade do |t|
    t.bigint "purchase_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fullfillment_status", default: "pending", null: false
    t.index ["purchase_id"], name: "index_split_purchases_on_purchase_id"
    t.index ["user_id"], name: "index_split_purchases_on_user_id"
  end

  create_table "stories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "content"
    t.bigint "user_id"
    t.boolean "disable_comments", default: false, null: false
    t.boolean "sensitive_content", default: false, null: false
    t.integer "cached_votes_total", default: 0
    t.integer "cached_votes_score", default: 0
    t.integer "cached_votes_up", default: 0
    t.integer "cached_votes_down", default: 0
    t.integer "cached_weighted_score", default: 0
    t.integer "cached_weighted_total", default: 0
    t.float "cached_weighted_average", default: 0.0
    t.bigint "number_of_views", default: 0, null: false
    t.bigint "category_id"
    t.boolean "published", default: false, null: false
    t.index ["category_id"], name: "index_stories_on_category_id"
    t.index ["user_id"], name: "index_stories_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "chat_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_subscriptions_on_chat_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token", limit: 128
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "company"
    t.string "city"
    t.string "country"
    t.text "about_me"
    t.string "title"
    t.bigint "number_of_visitors", default: 0, null: false
    t.string "website_url"
    t.string "display_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  add_foreign_key "activities", "users"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "rewards"
  add_foreign_key "carts", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "creations", "categories"
  add_foreign_key "creations", "users"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users"
  add_foreign_key "purchases", "carts"
  add_foreign_key "purchases", "users"
  add_foreign_key "rewards", "categories"
  add_foreign_key "rewards", "users"
  add_foreign_key "settings", "users"
  add_foreign_key "split_purchases", "purchases"
  add_foreign_key "split_purchases", "users"
  add_foreign_key "stories", "categories"
  add_foreign_key "stories", "users"
  add_foreign_key "subscriptions", "chats"
  add_foreign_key "subscriptions", "users"
end
