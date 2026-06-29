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

ActiveRecord::Schema[8.1].define(version: 2026_06_29_155302) do
  create_table "active_admin_comments", force: :cascade do |t|
    t.bigint "author_id"
    t.string "author_type"
    t.text "body"
    t.datetime "created_at", null: false
    t.string "namespace"
    t.bigint "resource_id"
    t.string "resource_type"
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "certifications", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "duration"
    t.string "modality"
    t.decimal "price"
    t.integer "seats_available"
    t.string "slug"
    t.date "start_date"
    t.boolean "status"
    t.text "syllabus"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "certification_id", null: false
    t.datetime "created_at", null: false
    t.bigint "lead_id", null: false
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["certification_id"], name: "index_enrollments_on_certification_id"
    t.index ["lead_id"], name: "index_enrollments_on_lead_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.text "description"
    t.datetime "end_date"
    t.datetime "start_date"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "leads", force: :cascade do |t|
    t.string "career"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.text "notes"
    t.string "phone"
    t.string "status"
    t.string "student_id"
    t.datetime "updated_at", null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.string "career"
    t.datetime "created_at", null: false
    t.string "email"
    t.integer "event_id"
    t.string "faculty"
    t.string "is_uanl"
    t.string "matricula"
    t.string "name"
    t.string "phone"
    t.string "role"
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_registrations_on_event_id"
  end

  add_foreign_key "enrollments", "certifications"
  add_foreign_key "enrollments", "leads"
  add_foreign_key "registrations", "events"
end
