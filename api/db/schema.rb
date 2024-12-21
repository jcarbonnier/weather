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

ActiveRecord::Schema[7.1].define(version: 2024_12_19_000011) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  create_table "users_weather_locations", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "weather_location_id", null: false
    t.index ["user_id", "weather_location_id"], name: "idx_on_user_id_weather_location_id_4f952a9370"
  end

  create_table "weather_forecasts", force: :cascade do |t|
    t.integer "weather_location_id"
    t.json "forecast"
    t.json "current"
    t.date "current_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["weather_location_id", "current_date"], name: "index_location_and_date", unique: true
  end

  create_table "weather_locations", force: :cascade do |t|
    t.string "name"
    t.string "region"
    t.string "country"
    t.decimal "lat"
    t.decimal "lon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lat", "lon"], name: "index_lat_lon"
    t.index ["name"], name: "index_weather_locations_on_name"
  end

end
