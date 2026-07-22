# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.

ActiveRecord::Schema.define(version: 2026_07_22_000003) do

  create_table "dim_layanan", primary_key: "sk_layanan", id: :serial, force: :cascade, comment: "Dimensi jenis layanan pengiriman PT Pos." do |t|
    t.string "service", null: false, comment: "Nama layanan utama"
    t.string "sub_service", comment: "Sub-layanan"
  end

  create_table "dim_lokasi", primary_key: "sk_lokasi", id: :serial, force: :cascade, comment: "Dimensi lokasi operasional (KPRK/Nopen)." do |t|
    t.string "location_name", null: false, comment: "Nama lokasi operasional"
    t.string "location_type", comment: "Tipe lokasi (KPRK, Agen)"
    t.string "regional", comment: "Regional wilayah PT Pos"
    t.string "nokprk", comment: "Nomor KPRK"
    t.string "nopen", comment: "Nomor Pendirian (Nopen)"
  end

  create_table "dim_penerima", primary_key: "sk_penerima", id: :serial, force: :cascade, comment: "Dimensi profil penerima paket." do |t|
    t.string "receiver_name", null: false, comment: "Nama lengkap penerima"
    t.string "receiver_phone", comment: "Nomor telepon penerima"
    t.string "receiver_address", comment: "Alamat utama penerima"
    t.string "receiver_address_detail", comment: "Detail alamat penerima"
  end

  create_table "dim_pengirim", primary_key: "sk_pengirim", id: :serial, force: :cascade, comment: "Dimensi profil pengirim paket." do |t|
    t.string "sender_name", null: false, comment: "Nama lengkap pengirim"
    t.string "sender_phone", comment: "Nomor telepon pengirim"
    t.string "sender_address", comment: "Alamat lengkap pengirim"
    t.string "customer_code", comment: "Kode unik pelanggan"
    t.string "segment_is_korporat", comment: "Segmen pelanggan (Korporat/Ritel)"
  end

  create_table "dim_status", primary_key: "sk_status", id: :serial, force: :cascade, comment: "Dimensi status pengiriman dan transaksi." do |t|
    t.string "connote_state", null: false, comment: "Status terakhir resi"
    t.string "payment_type_name", comment: "Metode pembayaran"
    t.string "channel", comment: "Channel transaksi"
    t.string "cod", comment: "Status COD"
  end

  create_table "fact_pengiriman", primary_key: "_id", id: :string, force: :cascade, comment: "Tabel Fakta utama berisi semua kolom transaksi dan metrik yang direquest." do |t|
    t.string "connote__connote_code", null: false, comment: "Nomor Resi / Connote Code (Degenerate Dimension)"
    
    # Kunci Relasi (Foreign Keys)
    t.integer "sk_layanan", null: false, comment: "FK ke dim_layanan"
    t.integer "sk_pengirim", null: false, comment: "FK ke dim_pengirim"
    t.integer "sk_penerima", null: false, comment: "FK ke dim_penerima"
    t.integer "sk_lokasi", null: false, comment: "FK ke dim_lokasi"
    t.integer "sk_status", null: false, comment: "FK ke dim_status"
    
    # Kolom Identitas & Teks yang dikembalikan
    t.string "connote__zone_code_from", comment: "Kode zona asal"
    t.string "connote__zone_code_to", comment: "Kode zona tujuan"
    t.string "created_by__id", comment: "ID Pembuat data"
    t.string "location_id", comment: "ID Lokasi Original"
    t.string "customer_code", comment: "Kode Customer Original"
    
    # Kolom Metrik Angka / Uang (sesuai daftar)
    t.decimal "connote__actual_weight", precision: 10, scale: 2, default: "0.0", comment: "Berat aktual"
    t.decimal "connote__chargeable_weight", precision: 10, scale: 2, default: "0.0", comment: "Berat yang ditagihkan"
    t.decimal "connote__connote_amount", precision: 15, scale: 2, default: "0.0", comment: "Total biaya pengiriman dasar"
    t.decimal "connote__connote_service_price", precision: 15, scale: 2, default: "0.0", comment: "Harga layanan per satuan"
    t.integer "connote__connote_sla_day", default: 0, comment: "SLA estimasi hari sampai"
    t.decimal "connote__connote_surcharge_amount", precision: 15, scale: 2, default: "0.0", comment: "Total biaya tambahan"
    t.decimal "connote__surcharge_amount", precision: 15, scale: 2, default: "0.0", comment: "Komponen biaya tambahan spesifik"
    t.decimal "connote__volume_weight", precision: 10, scale: 2, default: "0.0", comment: "Berat volumetrik"
    t.decimal "custom_field__cod_value", precision: 15, scale: 2, default: "0.0", comment: "Nilai uang COD"
    t.decimal "custom_field__discount_from_formula", precision: 15, scale: 2, default: "0.0", comment: "Nilai diskon"
    t.decimal "custom_field__ppn_basetariff", precision: 15, scale: 2, default: "0.0", comment: "PPN tarif dasar"
    t.decimal "custom_field__ppn_insurance", precision: 15, scale: 2, default: "0.0", comment: "PPN asuransi"
    t.decimal "custom_field__sla_duration", precision: 10, scale: 2, default: "0.0", comment: "Durasi nyata SLA"
    t.decimal "koli_data__koli_custom_field__harga_barang", precision: 15, scale: 2, default: "0.0", comment: "Harga barang aktual (asuransi)"
    
    # Kolom Waktu / Tanggal
    t.datetime "connote__created_at", comment: "Waktu transaksi dibuat"
    t.datetime "connote__updated_at", comment: "Waktu terakhir diupdate"
    t.datetime "consume_at", comment: "Waktu data dikonsumsi"
    t.datetime "etl_date", comment: "Waktu ditarik ke DWH"
    t.datetime "partition_year_month", comment: "Partisi tabel"
    
    t.index ["sk_layanan"], name: "idx_fact_pengiriman_on_sk_layanan"
    t.index ["sk_pengirim"], name: "idx_fact_pengiriman_on_sk_pengirim"
    t.index ["sk_penerima"], name: "idx_fact_pengiriman_on_sk_penerima"
    t.index ["sk_lokasi"], name: "idx_fact_pengiriman_on_sk_lokasi"
    t.index ["sk_status"], name: "idx_fact_pengiriman_on_sk_status"
    t.index ["connote__connote_code"], name: "idx_fact_pengiriman_on_connote_code"
  end

  add_foreign_key "fact_pengiriman", "dim_layanan", column: "sk_layanan", primary_key: "sk_layanan"
  add_foreign_key "fact_pengiriman", "dim_lokasi", column: "sk_lokasi", primary_key: "sk_lokasi"
  add_foreign_key "fact_pengiriman", "dim_penerima", column: "sk_penerima", primary_key: "sk_penerima"
  add_foreign_key "fact_pengiriman", "dim_pengirim", column: "sk_pengirim", primary_key: "sk_pengirim"
  add_foreign_key "fact_pengiriman", "dim_status", column: "sk_status", primary_key: "sk_status"

end
