# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.

ActiveRecord::Schema.define(version: 2026_07_22_000001) do

  create_table "dim_layanan", primary_key: "sk_layanan", id: :serial, force: :cascade, comment: "Dimensi yang menyimpan informasi jenis layanan pengiriman PT Pos (contoh: Pos Instan, Reguler, dll)." do |t|
    t.string "service", null: false, comment: "Nama layanan utama"
    t.string "sub_service", comment: "Sub-layanan atau detail tambahan dari service utama"
  end

  create_table "dim_lokasi", primary_key: "sk_lokasi", id: :serial, force: :cascade, comment: "Dimensi lokasi geografis dan kantor operasional (KPRK/Nopen)." do |t|
    t.string "location_name", null: false, comment: "Nama lokasi operasional / kantor pos"
    t.string "location_type", comment: "Tipe lokasi (KPRK, Agen, dll)"
    t.string "regional", comment: "Pembagian regional wilayah PT Pos"
    t.string "nokprk", comment: "Nomor KPRK (Kantor Pos Pemeriksa)"
    t.string "nopen", comment: "Nomor Pendirian (Nopen) Kantor Pos"
    t.string "zone_code_from", comment: "Kode zona keberangkatan paket"
  end

  create_table "dim_penerima", primary_key: "sk_penerima", id: :serial, force: :cascade, comment: "Dimensi profil penerima paket (Consignee)." do |t|
    t.string "receiver_name", null: false, comment: "Nama lengkap penerima"
    t.string "receiver_phone", comment: "Nomor telepon/HP penerima"
    t.string "receiver_address", comment: "Alamat utama penerima"
    t.string "receiver_address_detail", comment: "Detail alamat (RT/RW, Patokan, dll)"
  end

  create_table "dim_pengirim", primary_key: "sk_pengirim", id: :serial, force: :cascade, comment: "Dimensi profil pengirim paket (Shipper / Sender)." do |t|
    t.string "sender_name", null: false, comment: "Nama lengkap pengirim"
    t.string "sender_phone", comment: "Nomor telepon/HP pengirim"
    t.string "sender_address", comment: "Alamat lengkap pengirim"
    t.string "customer_code", comment: "Kode unik pelanggan (jika ada)"
    t.string "segment_is_korporat", comment: "Segmen pelanggan (True jika Korporat, False jika Ritel)"
  end

  create_table "dim_status", primary_key: "sk_status", id: :serial, force: :cascade, comment: "Dimensi status pengiriman, metode pembayaran, dan metode channel transaksi." do |t|
    t.string "connote_state", null: false, comment: "Status terakhir resi (Delivered, In Transit, dll)"
    t.string "payment_type_name", comment: "Metode pembayaran (Cash, Cashless, Transfer)"
    t.string "channel", comment: "Channel transaksi (Loket, Aplikasi, dll)"
    t.string "cod", comment: "Status COD (Apakah menggunakan fitur COD atau tidak)"
  end

  create_table "fact_pengiriman", primary_key: "_id", id: :string, force: :cascade, comment: "Tabel Fakta utama menyimpan transaksi pengiriman harian dan metrik (berat, harga, SLA)." do |t|
    t.integer "sk_layanan", null: false, comment: "Foreign key ke tabel dim_layanan"
    t.integer "sk_pengirim", null: false, comment: "Foreign key ke tabel dim_pengirim"
    t.integer "sk_penerima", null: false, comment: "Foreign key ke tabel dim_penerima"
    t.integer "sk_lokasi", null: false, comment: "Foreign key ke tabel dim_lokasi"
    t.integer "sk_status", null: false, comment: "Foreign key ke tabel dim_status"
    t.decimal "actual_weight", precision: 10, scale: 2, default: "0.0", comment: "Berat asli (aktual) dari paket dalam satuan gram/kg"
    t.decimal "chargeable_weight", precision: 10, scale: 2, default: "0.0", comment: "Berat yang ditagihkan (setelah mempertimbangkan dimensi)"
    t.decimal "connote_amount", precision: 15, scale: 2, default: "0.0", comment: "Total biaya pengiriman dasar"
    t.decimal "service_price", precision: 15, scale: 2, default: "0.0", comment: "Harga layanan per satuan"
    t.integer "sla_day", default: 0, comment: "SLA (Service Level Agreement) estimasi waktu sampai dalam hari"
    t.decimal "connote_surcharge_amount", precision: 15, scale: 2, default: "0.0", comment: "Total biaya tambahan (Surcharge)"
    t.decimal "surcharge_amount", precision: 15, scale: 2, default: "0.0", comment: "Komponen biaya tambahan spesifik"
    t.decimal "volume_weight", precision: 10, scale: 2, default: "0.0", comment: "Berat volumetrik paket"
    t.decimal "discount_from_formula", precision: 15, scale: 2, default: "0.0", comment: "Nilai diskon yang didapat"
    t.decimal "ppn_basetariff", precision: 15, scale: 2, default: "0.0", comment: "Nilai PPN dari tarif dasar"
    t.decimal "ppn_insurance", precision: 15, scale: 2, default: "0.0", comment: "Nilai PPN dari asuransi"
    t.decimal "sla_duration", precision: 10, scale: 2, default: "0.0", comment: "Durasi nyata SLA"
    t.decimal "harga_barang", precision: 15, scale: 2, default: "0.0", comment: "Harga barang aktual (khusus barang berharga/asuransi)"
    t.datetime "created_at", comment: "Waktu resi/transaksi dibuat di sistem"
    t.datetime "updated_at", comment: "Waktu terakhir resi/transaksi diupdate"
    t.datetime "etl_date", comment: "Waktu data ditarik ke dalam Data Warehouse"
    t.datetime "consume_at", comment: "Waktu data selesai diproses/dikonsumsi"
    t.datetime "partition_year_month", comment: "Partisi tabel berdasarkan Tahun dan Bulan"
    
    t.index ["sk_layanan"], name: "idx_fact_pengiriman_on_sk_layanan"
    t.index ["sk_pengirim"], name: "idx_fact_pengiriman_on_sk_pengirim"
    t.index ["sk_penerima"], name: "idx_fact_pengiriman_on_sk_penerima"
    t.index ["sk_lokasi"], name: "idx_fact_pengiriman_on_sk_lokasi"
    t.index ["sk_status"], name: "idx_fact_pengiriman_on_sk_status"
    t.index ["created_at"], name: "idx_fact_pengiriman_on_created_at"
  end

  add_foreign_key "fact_pengiriman", "dim_layanan", column: "sk_layanan", primary_key: "sk_layanan"
  add_foreign_key "fact_pengiriman", "dim_lokasi", column: "sk_lokasi", primary_key: "sk_lokasi"
  add_foreign_key "fact_pengiriman", "dim_penerima", column: "sk_penerima", primary_key: "sk_penerima"
  add_foreign_key "fact_pengiriman", "dim_pengirim", column: "sk_pengirim", primary_key: "sk_pengirim"
  add_foreign_key "fact_pengiriman", "dim_status", column: "sk_status", primary_key: "sk_status"

end
