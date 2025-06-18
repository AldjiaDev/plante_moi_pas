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

ActiveRecord::Schema[7.2].define(version: 2025_06_18_133937) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "plant_logs", force: :cascade do |t|
    t.bigint "plant_id", null: false
    t.date "date"
    t.boolean "watered"
    t.boolean "quest_done"
    t.string "mood"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "quest_id"
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

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "plant_logs", "plants"
  add_foreign_key "plant_logs", "quests"
  add_foreign_key "plants", "users"
end
