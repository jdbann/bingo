# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_28_133845) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calls", force: :cascade do |t|
    t.string "name"
    t.bigint "round_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "hidden", default: true
    t.index ["round_id"], name: "index_calls_on_round_id"
  end

  create_table "card_calls", force: :cascade do |t|
    t.bigint "card_id", null: false
    t.bigint "call_id", null: false
    t.boolean "marked", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["call_id"], name: "index_card_calls_on_call_id"
    t.index ["card_id"], name: "index_card_calls_on_card_id"
  end

  create_table "cards", force: :cascade do |t|
    t.bigint "round_id", null: false
    t.string "code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_cards_on_code", unique: true
    t.index ["round_id"], name: "index_cards_on_round_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "header"
    t.string "footer"
  end

  add_foreign_key "calls", "rounds"
  add_foreign_key "card_calls", "calls"
  add_foreign_key "card_calls", "cards"
  add_foreign_key "cards", "rounds"
end
