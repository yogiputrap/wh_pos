# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.

ActiveRecord::Schema.define(version: 2026_07_22_000000) do

  create_table "dim_layanan", primary_key: "sk_layanan", id: :serial, force: :cascade do |t|
    t.string "service"
    t.string "sub_service"
  end

  create_table "dim_lokasi", primary_key: "sk_lokasi", id: :serial, force: :cascade do |t|
    t.string "location_name"
    t.string "location_type"
    t.string "regional"
    t.string "nokprk"
    t.string "nopen"
    t.string "zone_code_from"
  end

  create_table "dim_penerima", primary_key: "sk_penerima", id: :serial, force: :cascade do |t|
    t.string "receiver_name"
    t.string "receiver_phone"
    t.string "receiver_address"
    t.string "receiver_address_detail"
  end

  create_table "dim_pengirim", primary_key: "sk_pengirim", id: :serial, force: :cascade do |t|
    t.string "sender_name"
    t.string "sender_phone"
    t.string "sender_address"
    t.string "customer_code"
    t.string "segment_is_korporat"
  end

  create_table "dim_status", primary_key: "sk_status", id: :serial, force: :cascade do |t|
    t.string "connote_state"
    t.string "payment_type_name"
    t.string "channel"
    t.string "cod"
  end

  create_table "fact_pengiriman", primary_key: "_id", id: :string, force: :cascade do |t|
    t.integer "sk_layanan"
    t.integer "sk_pengirim"
    t.integer "sk_penerima"
    t.integer "sk_lokasi"
    t.integer "sk_status"
    t.float "actual_weight"
    t.float "chargeable_weight"
    t.float "connote_amount"
    t.float "service_price"
    t.float "sla_day"
    t.float "connote_surcharge_amount"
    t.float "surcharge_amount"
    t.float "volume_weight"
    t.float "discount_from_formula"
    t.float "ppn_basetariff"
    t.float "ppn_insurance"
    t.float "sla_duration"
    t.float "harga_barang"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "etl_date"
    t.datetime "consume_at"
    t.datetime "partition_year_month"
  end

  add_foreign_key "fact_pengiriman", "dim_layanan", column: "sk_layanan", primary_key: "sk_layanan"
  add_foreign_key "fact_pengiriman", "dim_lokasi", column: "sk_lokasi", primary_key: "sk_lokasi"
  add_foreign_key "fact_pengiriman", "dim_penerima", column: "sk_penerima", primary_key: "sk_penerima"
  add_foreign_key "fact_pengiriman", "dim_pengirim", column: "sk_pengirim", primary_key: "sk_pengirim"
  add_foreign_key "fact_pengiriman", "dim_status", column: "sk_status", primary_key: "sk_status"

end
