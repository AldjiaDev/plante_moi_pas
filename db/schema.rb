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

ActiveRecord::Schema[7.2].define(version: 2025_06_21_105311) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "care_logs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "plant_id", null: false
    t.boolean "watered"
    t.boolean "quest_done"
    t.string "mood"
    t.text "quest_response"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id"], name: "index_care_logs_on_plant_id"
    t.index ["user_id"], name: "index_care_logs_on_user_id"
  end

  create_table "plant_logs", force: :cascade do |t|
    t.bigint "plant_id", null: false
    t.date "date"
    t.boolean "watered"
    t.boolean "quest_done"
    t.string "mood"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "quest_id"
    t.text "quest_response"
    t.index ["plant_id"], name: "index_plant_logs_on_plant_id"
    t.index ["quest_id"], name: "index_plant_logs_on_quest_id"
  end

  create_table "plants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "last_watered_at"
    t.integer "consecutive_days_watered"
    t.string "mood"
    t.integer "leaves"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "growth_stage"
    t.string "personality"
    t.datetime "last_mood_update_at"
    t.string "color"
    t.string "pot_style"
    t.string "accessory"
    t.index ["user_id"], name: "index_plants_on_user_id"
  end

  create_table "quests", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "quest_type"
    t.integer "reward_points"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quiz_questions", force: :cascade do |t|
    t.string "question"
    t.string "answer"
    t.text "options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_achievements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "achievement_id", null: false
    t.datetime "unlocked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["achievement_id"], name: "index_user_achievements_on_achievement_id"
    t.index ["user_id"], name: "index_user_achievements_on_user_id"
  end

  create_table "user_quiz_answers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "quiz_question_id", null: false
    t.string "given_answer"
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_question_id"], name: "index_user_quiz_answers_on_quiz_question_id"
    t.index ["user_id"], name: "index_user_quiz_answers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.integer "leaves", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "care_logs", "plants"
  add_foreign_key "care_logs", "users"
  add_foreign_key "plant_logs", "plants"
  add_foreign_key "plant_logs", "quests"
  add_foreign_key "plants", "users"
  add_foreign_key "user_achievements", "achievements"
  add_foreign_key "user_achievements", "users"
  add_foreign_key "user_quiz_answers", "quiz_questions"
  add_foreign_key "user_quiz_answers", "users"
end
