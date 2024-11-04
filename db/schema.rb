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

ActiveRecord::Schema[7.2].define(version: 2024_11_04_104453) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calculators", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.bigint "field_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field_id"], name: "index_categories_on_field_id"
  end

  create_table "fields", force: :cascade do |t|
    t.string "label"
    t.string "var_name"
    t.string "field_type"
    t.bigint "calculator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calculator_id"], name: "index_fields_on_calculator_id"
  end

  create_table "formulas", force: :cascade do |t|
    t.string "expression"
    t.bigint "calculator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calculator_id"], name: "index_formulas_on_calculator_id"
  end
end
