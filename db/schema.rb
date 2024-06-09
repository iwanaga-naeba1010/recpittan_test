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

ActiveRecord::Schema[7.0].define(version: 2024_06_08_145617) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "channel_plan_subscriber_memos", force: :cascade do |t|
    t.bigint "channel_plan_subscriber_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_plan_subscriber_id"], name: "index_subscriber_memos_on__subscriber_id"
  end

  create_table "channel_plan_subscribers", force: :cascade do |t|
    t.integer "kind"
    t.integer "status", default: 0
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_channel_plan_subscribers_on_company_id", unique: true
  end

  create_table "chats", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.text "message"
    t.boolean "is_read"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "file"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "facility_name"
    t.string "person_in_charge_name"
    t.string "person_in_charge_name_kana"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "zip"
    t.string "prefecture"
    t.string "city"
    t.string "street"
    t.string "building"
    t.string "tel"
    t.integer "genre", default: 0
    t.text "feature"
    t.string "url"
    t.integer "capacity"
    t.string "nursing_care_level"
    t.text "request"
    t.string "memo"
    t.string "facility_name_kana"
  end

  create_table "company_memos", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_memos_on_company_id"
  end

  create_table "company_tags", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "evaluation_replies", force: :cascade do |t|
    t.text "message", null: false
    t.bigint "evaluation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluation_id"], name: "index_evaluation_replies_on_evaluation_id", unique: true
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
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "is_public", default: true
  end

  create_table "favorite_recreations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "recreation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recreation_id"], name: "index_favorite_recreations_on_recreation_id"
    t.index ["user_id", "recreation_id"], name: "index_favorite_recreations_on_user_id_and_recreation_id", unique: true
    t.index ["user_id"], name: "index_favorite_recreations_on_user_id"
  end

  create_table "invoice_informations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "code"
    t.string "zip", null: false
    t.string "prefecture", null: false
    t.string "city", null: false
    t.string "street", null: false
    t.string "building"
    t.string "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company_name", null: false
    t.string "email", null: false
    t.index ["user_id"], name: "index_invoice_informations_on_user_id"
  end

  create_table "online_recreation_channel_download_images", force: :cascade do |t|
    t.text "image", null: false
    t.integer "kind", null: false
    t.bigint "online_recreation_channel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["online_recreation_channel_id", "kind"], name: "index_channel_dw_images_on_channel_id_and_kind", unique: true
    t.index ["online_recreation_channel_id"], name: "index_online_recreation_channel_dw_images_on_channel_id"
  end

  create_table "online_recreation_channel_recreations", force: :cascade do |t|
    t.bigint "online_recreation_channel_id", null: false
    t.string "title", null: false
    t.text "link", null: false
    t.text "memo"
    t.date "date"
    t.text "zoom_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "datetime"
    t.index ["online_recreation_channel_id", "date"], name: "index_channel_recreations_on_channel_date", unique: true
    t.index ["online_recreation_channel_id"], name: "index_channel_recreations_on_channel_id"
  end

  create_table "online_recreation_channels", force: :cascade do |t|
    t.text "top_image"
    t.integer "status", null: false
    t.date "period", null: false
    t.text "calendar_memo"
    t.text "zoom_memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_dates", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.string "year"
    t.string "month"
    t.string "date"
    t.string "start_hour"
    t.string "start_minute"
    t.string "end_hour"
    t.string "end_minute"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "order_memos", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.text "body"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "recreation_id", null: false
    t.integer "number_of_people"
    t.integer "status"
    t.string "prefecture"
    t.string "city"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "is_accepted", default: false
    t.datetime "start_at", precision: nil
    t.integer "transportation_expenses", default: 0
    t.integer "expenses", default: 0
    t.string "zip"
    t.string "street"
    t.string "building"
    t.integer "number_of_facilities"
    t.integer "price", default: 0
    t.integer "amount", default: 0
    t.integer "material_price", default: 0
    t.integer "material_amount", default: 0
    t.integer "additional_facility_fee", default: 0
    t.integer "support_price", default: 0
    t.datetime "end_at", precision: nil
    t.string "contract_number"
    t.integer "final_check_status"
    t.string "memo"
    t.string "coupon_code"
    t.boolean "is_open", default: true, null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "title"
    t.text "description"
    t.text "image"
    t.string "position"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "recreation_images", force: :cascade do |t|
    t.bigint "recreation_id", null: false
    t.text "image"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "kind", default: 0
    t.string "filename"
  end

  create_table "recreation_memos", force: :cascade do |t|
    t.bigint "recreation_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recreation_id"], name: "index_recreation_memos_on_recreation_id"
  end

  create_table "recreation_plan_estimates", force: :cascade do |t|
    t.string "estimate_number", null: false
    t.integer "start_month", null: false
    t.integer "transportation_expenses", null: false
    t.integer "number_of_people", null: false
    t.bigint "recreation_plan_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recreation_plan_id"], name: "index_recreation_plan_estimates_on_recreation_plan_id"
    t.index ["user_id", "estimate_number"], name: "index_recreation_plan_estimates_on_user_id_and_estimate_number", unique: true
    t.index ["user_id"], name: "index_recreation_plan_estimates_on_user_id"
  end

  create_table "recreation_plan_tags", force: :cascade do |t|
    t.bigint "recreation_plan_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recreation_plan_id"], name: "index_recreation_plan_tags_on_recreation_plan_id"
    t.index ["tag_id"], name: "index_recreation_plan_tags_on_tag_id"
  end

  create_table "recreation_plans", force: :cascade do |t|
    t.string "title", null: false
    t.string "code", null: false
    t.integer "release_status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "adjustment_fee"
    t.bigint "company_id"
    t.index ["code"], name: "index_recreation_plans_on_code", unique: true
    t.index ["company_id"], name: "index_recreation_plans_on_company_id"
  end

  create_table "recreation_prefectures", force: :cascade do |t|
    t.bigint "recreation_id", null: false
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "recreation_profiles", force: :cascade do |t|
    t.bigint "recreation_id", null: false
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "recreation_recreation_plans", force: :cascade do |t|
    t.bigint "recreation_id", null: false
    t.bigint "recreation_plan_id", null: false
    t.integer "month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recreation_id"], name: "index_recreation_recreation_plans_on_recreation_id"
    t.index ["recreation_plan_id"], name: "index_recreation_recreation_plans_on_recreation_plan_id"
  end

  create_table "recreation_tags", force: :cascade do |t|
    t.bigint "recreation_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
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
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "youtube_id"
    t.string "flyer_color"
    t.integer "price"
    t.integer "material_price"
    t.integer "material_amount"
    t.integer "capacity"
    t.integer "amount"
    t.string "base_code"
    t.bigint "user_id", null: false
    t.boolean "is_public_price", default: true
    t.integer "additional_facility_fee", default: 2000
    t.integer "category", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.integer "kind", default: 0, null: false
    t.integer "number_of_past_events", default: 0, null: false
    t.string "memo"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.integer "number_of_facilities"
    t.integer "number_of_people"
    t.integer "transportation_expenses"
    t.integer "expenses"
    t.text "body"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "status"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "kind"
  end

  create_table "top_banners", force: :cascade do |t|
    t.string "image", null: false
    t.string "url"
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_memos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_memos_on_user_id"
  end

  create_table "user_recreation_plans", force: :cascade do |t|
    t.string "code", null: false
    t.bigint "recreation_plan_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_user_recreation_plans_on_code", unique: true
    t.index ["recreation_plan_id"], name: "index_user_recreation_plans_on_recreation_plan_id"
    t.index ["user_id"], name: "index_user_recreation_plans_on_user_id"
  end

  create_table "user_recreation_recreation_plans", force: :cascade do |t|
    t.bigint "recreation_id", null: false
    t.bigint "user_recreation_plan_id", null: false
    t.integer "month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recreation_id"], name: "index_user_rec_rec_plans_on_rec_id"
    t.index ["user_recreation_plan_id"], name: "index_user_rec_rec_plans_on_user_rec_plan_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "role", default: 0, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "company_id"
    t.string "username"
    t.string "username_kana"
    t.string "title"
    t.string "memo"
    t.integer "approval_status", default: 0
  end

  create_table "zooms", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.integer "price", default: 0
    t.integer "created_by"
    t.string "url"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  add_foreign_key "channel_plan_subscriber_memos", "channel_plan_subscribers"
  add_foreign_key "channel_plan_subscribers", "companies"
  add_foreign_key "chats", "orders", name: "chats_order_id_fkey"
  add_foreign_key "chats", "users", name: "chats_user_id_fkey"
  add_foreign_key "company_memos", "companies"
  add_foreign_key "company_tags", "companies", name: "company_tags_company_id_fkey"
  add_foreign_key "company_tags", "tags", name: "company_tags_tag_id_fkey"
  add_foreign_key "evaluation_replies", "evaluations"
  add_foreign_key "evaluations", "reports", name: "evaluations_report_id_fkey"
  add_foreign_key "favorite_recreations", "recreations"
  add_foreign_key "favorite_recreations", "users"
  add_foreign_key "invoice_informations", "users"
  add_foreign_key "online_recreation_channel_download_images", "online_recreation_channels"
  add_foreign_key "online_recreation_channel_recreations", "online_recreation_channels"
  add_foreign_key "order_dates", "orders", name: "order_dates_order_id_fkey"
  add_foreign_key "order_memos", "orders", name: "order_memos_order_id_fkey"
  add_foreign_key "orders", "recreations", name: "orders_recreation_id_fkey"
  add_foreign_key "orders", "users", name: "orders_user_id_fkey"
  add_foreign_key "profiles", "users", name: "profiles_user_id_fkey"
  add_foreign_key "recreation_images", "recreations", name: "recreation_images_recreation_id_fkey"
  add_foreign_key "recreation_memos", "recreations"
  add_foreign_key "recreation_plan_estimates", "recreation_plans"
  add_foreign_key "recreation_plan_estimates", "users"
  add_foreign_key "recreation_plan_tags", "recreation_plans"
  add_foreign_key "recreation_plan_tags", "tags"
  add_foreign_key "recreation_prefectures", "recreations", name: "recreation_prefectures_recreation_id_fkey"
  add_foreign_key "recreation_profiles", "profiles", name: "recreation_profiles_profile_id_fkey"
  add_foreign_key "recreation_profiles", "recreations", name: "recreation_profiles_recreation_id_fkey"
  add_foreign_key "recreation_recreation_plans", "recreation_plans"
  add_foreign_key "recreation_recreation_plans", "recreations"
  add_foreign_key "recreation_tags", "recreations", name: "recreation_tags_recreation_id_fkey"
  add_foreign_key "recreation_tags", "tags", name: "recreation_tags_tag_id_fkey"
  add_foreign_key "recreations", "users", name: "recreations_user_id_fkey"
  add_foreign_key "reports", "orders", name: "reports_order_id_fkey"
  add_foreign_key "user_memos", "users"
  add_foreign_key "user_recreation_plans", "recreation_plans"
  add_foreign_key "user_recreation_plans", "users"
  add_foreign_key "user_recreation_recreation_plans", "recreations"
  add_foreign_key "user_recreation_recreation_plans", "user_recreation_plans"
  add_foreign_key "users", "companies", name: "users_company_id_fkey"
  add_foreign_key "zooms", "orders", name: "zooms_order_id_fkey"
end
