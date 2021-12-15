# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_15_132532) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chats", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.text "message"
    t.boolean "is_read"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "facility_name"
    t.string "person_in_charge_name"
    t.string "person_in_charge_name_kana"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "zip"
    t.string "prefecture"
    t.string "city"
    t.string "street"
    t.string "building"
    t.string "tel"
    t.string "address"
    t.string "phone"
    t.string "region"
    t.string "locality"
  end

  create_table "email_templates", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "explanation"
    t.string "title"
    t.text "body"
    t.text "signature"
    t.integer "kind"
  end

  create_table "evaluations", force: :cascade do |t|
    t.bigint "report_id", null: false
    t.integer "ingenuity"
    t.integer "communication"
    t.integer "smoothness"
    t.integer "price"
    t.integer "want_to_order_agein"
    t.text "message"
    t.text "other_message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["report_id"], name: "index_evaluations_on_report_id"
  end

  create_table "order_memos", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "recreation_id", null: false
    t.integer "number_of_people"
    t.integer "status"
    t.string "prefecture"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_accepted", default: false
    t.datetime "date_and_time"
    t.integer "transportation_expenses"
    t.integer "expenses"
    t.string "zip"
    t.string "street"
    t.string "building"
    t.integer "number_of_facilities"
  end

  create_table "plans", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.integer "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recreation_images", force: :cascade do |t|
    t.bigint "recreation_id", null: false
    t.text "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recreation_tags", force: :cascade do |t|
    t.bigint "recreation_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recreations", force: :cascade do |t|
    t.string "title"
    t.string "second_title"
    t.integer "minutes"
    t.text "description"
    t.text "flow_of_day"
    t.text "borrow_item"
    t.text "bring_your_own_item"
    t.text "extra_information"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "youtube_id"
    t.integer "price", default: 0, null: false
    t.string "flyer_color"
    t.string "prefectures", default: [], array: true
    t.integer "regular_price"
    t.integer "regular_material_price"
    t.integer "instructor_material_amount"
    t.integer "capacity"
    t.integer "instructor_amount"
    t.string "instructor_position"
    t.boolean "is_public"
    t.string "base_code"
    t.boolean "is_online", default: false
    t.bigint "user_id", null: false
    t.string "instructor_name"
    t.string "instructor_title"
    t.text "instructor_description"
    t.text "instructor_image"
    t.boolean "is_public_price", default: true
    t.integer "additional_facility_fee", default: 2000
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.integer "facility_count"
    t.integer "number_of_people"
    t.integer "transportation_expenses"
    t.integer "expenses"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
    t.index ["order_id"], name: "index_reports_on_order_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind"
  end

  create_table "users", force: :cascade do |t|
    t.integer "role", default: 0, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.string "username"
    t.string "username_kana"
  end

  add_foreign_key "chats", "orders", name: "chats_order_id_fkey"
  add_foreign_key "chats", "users", name: "chats_user_id_fkey"
  add_foreign_key "evaluations", "reports"
  add_foreign_key "order_memos", "orders", name: "order_memos_order_id_fkey"
  add_foreign_key "orders", "recreations", name: "orders_recreation_id_fkey"
  add_foreign_key "orders", "users", name: "orders_user_id_fkey"
  add_foreign_key "plans", "companies", name: "plans_company_id_fkey"
  add_foreign_key "recreation_images", "recreations", name: "recreation_images_recreation_id_fkey"
  add_foreign_key "recreation_tags", "recreations", name: "recreation_tags_recreation_id_fkey"
  add_foreign_key "recreation_tags", "tags", name: "recreation_tags_tag_id_fkey"
  add_foreign_key "recreations", "users", name: "recreations_user_id_fkey"
  add_foreign_key "reports", "orders"
  add_foreign_key "users", "companies", name: "users_company_id_fkey"
end
