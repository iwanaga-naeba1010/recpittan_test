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

ActiveRecord::Schema[7.2].define(version: 2025_02_26_132027) do
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
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "bank_name", null: false
    t.string "bank_code", null: false
    t.string "branch_name", null: false
    t.string "branch_code", null: false
    t.string "account_type", null: false
    t.string "account_number", null: false
    t.string "account_holder_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "account_number"], name: "index_bank_accounts_on_user_id_and_account_number", unique: true
    t.index ["user_id"], name: "index_bank_accounts_on_user_id"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "file"
    t.index ["order_id"], name: "index_chats_on_order_id"
    t.index ["user_id"], name: "index_chats_on_user_id"
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
    t.integer "genre", default: 0
    t.text "feature"
    t.string "url"
    t.integer "capacity"
    t.string "nursing_care_level"
    t.text "request"
    t.string "memo"
    t.string "facility_name_kana"
    t.string "trading_target_code"
    t.string "pref_code"
    t.string "manage_company_code"
    t.string "common_trading_target_code"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_tags_on_company_id"
    t.index ["tag_id"], name: "index_company_tags_on_tag_id"
  end

  create_table "divisions", force: :cascade do |t|
    t.string "classname"
    t.string "code"
    t.string "valuetext"
    t.integer "valueint"
    t.datetime "valuedate"
    t.integer "disporder"
    t.text "memo"
    t.string "key"
    t.boolean "i18n_flag", default: false
    t.string "i18n_class"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_public", default: true
    t.index ["report_id"], name: "index_evaluations_on_report_id"
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

  create_table "m_numberings", force: :cascade do |t|
    t.string "numbering_name", null: false
    t.string "numbering_unit", null: false
    t.text "numbering_datetime"
    t.string "code_name", null: false
    t.string "code", null: false
    t.integer "numbering_value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["numbering_name", "numbering_unit", "numbering_datetime", "code"], name: "idx_on_numbering_name_numbering_unit_numbering_date_5c271ae9b2", unique: true
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_dates_on_order_id"
  end

  create_table "order_desire_dates", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.integer "desire_no"
    t.date "desire_date"
    t.time "time_from"
    t.time "time_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_desire_dates_on_order_id"
  end

  create_table "order_memos", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_memos_on_order_id"
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
    t.boolean "is_managercontrol", default: false, null: false, comment: "運営管理フラグ"
    t.string "order_create_source_code", comment: "案件作成元区分"
    t.string "manage_company_code", comment: "案件管理会社区分"
    t.boolean "business_integration_flag", default: true, null: false, comment: "業務統合フラグ"
    t.boolean "is_withholding_tax", default: false, null: false, comment: "源泉徴収フラグ"
    t.datetime "status_updated_at", comment: "ステータス更新日"
    t.datetime "facility_request_approved_at", comment: "正式依頼承認日（ダウンロード日）"
    t.integer "approved_total_partner_payment", comment: "正式依頼承認時のパートナー謝礼全体（税込）"
    t.datetime "final_report_approved_at", comment: "施設の終了報告の承認日"
    t.decimal "tax_rate", precision: 15, scale: 3, comment: "消費税率"
    t.integer "tax_amount", comment: "消費税"
    t.integer "amount_with_tax", comment: "パートナー謝礼（税込）"
    t.integer "total_material_amount", comment: "材料費合計"
    t.integer "total_additional_facility_fee", comment: "追加施設費合計"
    t.integer "total_partner_payment_with_tax", comment: "パートナー謝礼全体（税込）"
    t.decimal "partner_fee_rate", precision: 15, scale: 3, comment: "パートナー手数料率"
    t.integer "additional_facility_fee_commission", comment: "追加施設手数料"
    t.integer "total_additional_facility_fee_commission", comment: "追加施設手数料計"
    t.boolean "partner_invoice_registration_flag", default: false, null: false, comment: "パートナーインボイス登録フラグ"
    t.decimal "non_invoice_partner_fee_rate", precision: 15, scale: 3, comment: "インボイス非登録パートナー手数率"
    t.integer "non_invoice_partner_fee", comment: "インボイス非登録パートナー手数料"
    t.integer "zoom_rental_fee", comment: "zoomレンタル料"
    t.integer "recreation_kind", comment: "レクマスタ、レク種類"
    t.boolean "is_zoom_rental", default: false, null: false, comment: "zoomレンタルフラグ"
    t.integer "zoom_rental_actual_fee", comment: "zoomレンタル使用料金"
    t.integer "partner_service_fee", comment: "パートナーサービス利用料"
    t.integer "partner_deduction_subtotal", comment: "パートナー控除小計"
    t.decimal "facility_fee_rate", precision: 15, scale: 3, comment: "施設手数料率"
    t.integer "facility_fee_base_amount", comment: "施設手数料計算金額"
    t.integer "facility_fee", comment: "施設手数料（税込）"
    t.integer "facility_service_fee", comment: "施設サービス利用料"
    t.integer "facility_fee_subtotal", comment: "施設手数料小計"
    t.decimal "withholding_tax_rate", precision: 15, scale: 3, comment: "源泉徴収税率"
    t.integer "withholding_tax_amount", comment: "源泉徴収税額"
    t.string "specific_facility_plan_management_code", comment: "特定施設プラン管理コード"
    t.integer "partner_payment_amount", comment: "パートナー支払額"
    t.integer "gross_profit_incl_tax", comment: "粗利（税込）"
    t.decimal "gross_profit_margin", precision: 15, scale: 3, comment: "粗利率"
    t.integer "facility_billing_amount", comment: "施設請求額"
    t.index ["recreation_id"], name: "index_orders_on_recreation_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "partner_infos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "phone_number"
    t.string "postal_code"
    t.string "prefecture"
    t.string "city"
    t.string "address1"
    t.string "address2"
    t.string "company_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_partner_infos_on_user_id"
  end

  create_table "pdf_files", force: :cascade do |t|
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "title"
    t.text "description"
    t.text "image"
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "recreation_images", force: :cascade do |t|
    t.bigint "recreation_id", null: false
    t.text "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind", default: 0
    t.string "filename"
    t.string "title"
    t.string "document_kind"
    t.index ["recreation_id"], name: "index_recreation_images_on_recreation_id"
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
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "recreation_id"], name: "index_recreation_prefectures_on_name_and_recreation_id", unique: true
    t.index ["recreation_id"], name: "index_recreation_prefectures_on_recreation_id"
  end

  create_table "recreation_profiles", force: :cascade do |t|
    t.bigint "recreation_id", null: false
    t.bigint "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_recreation_profiles_on_profile_id"
    t.index ["recreation_id"], name: "index_recreation_profiles_on_recreation_id"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recreation_id"], name: "index_recreation_tags_on_recreation_id"
    t.index ["tag_id"], name: "index_recreation_tags_on_tag_id"
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
    t.index ["user_id"], name: "index_recreations_on_user_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.integer "number_of_facilities"
    t.integer "number_of_people"
    t.integer "transportation_expenses"
    t.integer "expenses"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.index ["order_id"], name: "index_reports_on_order_id"
  end

  create_table "system_parameters", force: :cascade do |t|
    t.string "param_code"
    t.string "param_name"
    t.decimal "value_int", precision: 15, scale: 4
    t.string "value_text"
    t.datetime "applied_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.string "username"
    t.string "username_kana"
    t.string "title"
    t.string "memo"
    t.integer "approval_status", default: 0
    t.boolean "is_mfa_enabled", default: false, null: false
    t.datetime "mfa_authenticated_at"
    t.boolean "is_partner", default: false
    t.boolean "is_facility", default: false
    t.string "manage_company_code"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "zooms", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.integer "price", default: 0
    t.integer "created_by"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_zooms_on_order_id"
  end

  add_foreign_key "bank_accounts", "users"
  add_foreign_key "channel_plan_subscriber_memos", "channel_plan_subscribers"
  add_foreign_key "channel_plan_subscribers", "companies"
  add_foreign_key "chats", "orders"
  add_foreign_key "chats", "users"
  add_foreign_key "company_memos", "companies"
  add_foreign_key "company_tags", "companies"
  add_foreign_key "company_tags", "tags"
  add_foreign_key "evaluation_replies", "evaluations"
  add_foreign_key "evaluations", "reports"
  add_foreign_key "favorite_recreations", "recreations"
  add_foreign_key "favorite_recreations", "users"
  add_foreign_key "invoice_informations", "users"
  add_foreign_key "online_recreation_channel_download_images", "online_recreation_channels"
  add_foreign_key "online_recreation_channel_recreations", "online_recreation_channels"
  add_foreign_key "order_dates", "orders"
  add_foreign_key "order_desire_dates", "orders"
  add_foreign_key "order_memos", "orders"
  add_foreign_key "orders", "recreations"
  add_foreign_key "orders", "users"
  add_foreign_key "partner_infos", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "recreation_images", "recreations"
  add_foreign_key "recreation_memos", "recreations"
  add_foreign_key "recreation_plan_estimates", "recreation_plans"
  add_foreign_key "recreation_plan_estimates", "users"
  add_foreign_key "recreation_plan_tags", "recreation_plans"
  add_foreign_key "recreation_plan_tags", "tags"
  add_foreign_key "recreation_prefectures", "recreations"
  add_foreign_key "recreation_profiles", "profiles"
  add_foreign_key "recreation_profiles", "recreations"
  add_foreign_key "recreation_recreation_plans", "recreation_plans"
  add_foreign_key "recreation_recreation_plans", "recreations"
  add_foreign_key "recreation_tags", "recreations"
  add_foreign_key "recreation_tags", "tags"
  add_foreign_key "recreations", "users"
  add_foreign_key "reports", "orders"
  add_foreign_key "user_memos", "users"
  add_foreign_key "user_recreation_plans", "recreation_plans"
  add_foreign_key "user_recreation_plans", "users"
  add_foreign_key "user_recreation_recreation_plans", "recreations"
  add_foreign_key "user_recreation_recreation_plans", "user_recreation_plans"
  add_foreign_key "users", "companies"
  add_foreign_key "zooms", "orders"
end
