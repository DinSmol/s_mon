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

ActiveRecord::Schema.define(version: 2021_03_20_202515) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "active_periods", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "address"
    t.datetime "started_at", default: "2021-03-23 14:34:17"
    t.datetime "stopped_at"
    t.datetime "created_at", default: "2021-03-23 14:34:17"
    t.datetime "updated_at", default: "2021-03-23 14:34:17"
    t.index ["started_at"], name: "index_active_periods_on_started_at"
    t.index ["stopped_at"], name: "index_active_periods_on_stopped_at"
  end

  create_table "objects", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "address"
    t.string "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid "created_by"
    t.uuid "updated_by"
    t.boolean "disabled", default: false, null: false
  end

  create_table "stat_data", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "address"
    t.float "min"
    t.float "avg"
    t.float "max"
    t.float "mdev"
    t.float "loss"
    t.datetime "created_at", default: "2021-03-23 14:34:17"
    t.datetime "updated_at", default: "2021-03-23 14:34:17"
  end

end
