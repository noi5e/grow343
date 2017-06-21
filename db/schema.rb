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

ActiveRecord::Schema.define(version: 20170621050452) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.bigint "learning_result_id", null: false
    t.bigint "learning_objective_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["learning_objective_id"], name: "index_achievements_on_learning_objective_id"
    t.index ["learning_result_id"], name: "index_achievements_on_learning_result_id"
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "learning_objectives", force: :cascade do |t|
    t.string "name"
    t.bigint "learning_target_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["learning_target_id"], name: "index_learning_objectives_on_learning_target_id"
  end

  create_table "learning_resources", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.bigint "learning_target_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["learning_target_id"], name: "index_learning_resources_on_learning_target_id"
  end

  create_table "learning_results", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "learning_target_id", null: false
    t.float "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["learning_target_id"], name: "index_learning_results_on_learning_target_id"
    t.index ["student_id"], name: "index_learning_results_on_student_id"
  end

  create_table "learning_targets", force: :cascade do |t|
    t.integer "grade"
    t.integer "version"
    t.string "title"
    t.text "common_core_state_standards"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_details", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "teacher_id", null: false
    t.integer "english_second_language"
    t.integer "individualized_education_plan"
    t.integer "graduation_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_student_details_on_student_id"
    t.index ["teacher_id"], name: "index_student_details_on_teacher_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["id", "type"], name: "index_users_on_id_and_type", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "achievements", "learning_objectives"
  add_foreign_key "achievements", "learning_results"
  add_foreign_key "learning_objectives", "learning_targets"
  add_foreign_key "learning_resources", "learning_targets"
  add_foreign_key "learning_results", "learning_targets"
  add_foreign_key "learning_results", "users", column: "student_id"
  add_foreign_key "student_details", "users", column: "student_id"
  add_foreign_key "student_details", "users", column: "teacher_id"
end
