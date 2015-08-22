# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150822015358) do

  create_table "geo_cities", force: :cascade do |t|
    t.string  "name"
    t.string  "country_code", limit: 2
    t.integer "region_id"
    t.integer "district_id"
    t.float   "latitude"
    t.float   "longitude"
  end

  add_index "geo_cities", ["country_code"], name: "index_geo_cities_on_country_code"

  create_table "geo_continents", id: false, force: :cascade do |t|
    t.string "code", limit: 2
    t.string "name"
  end

  add_index "geo_continents", ["code"], name: "index_geo_continents_on_code"

  create_table "geo_countries", id: false, force: :cascade do |t|
    t.string "code",           limit: 2
    t.string "name"
    t.string "continent_code", limit: 2
  end

  add_index "geo_countries", ["code"], name: "index_geo_countries_on_code"
  add_index "geo_countries", ["continent_code"], name: "index_geo_countries_on_continent_code"

  create_table "geo_districts", force: :cascade do |t|
    t.string  "code"
    t.string  "country_code"
    t.string  "name"
    t.integer "region_id"
  end

  add_index "geo_districts", ["code"], name: "index_geo_districts_on_code"
  add_index "geo_districts", ["country_code"], name: "index_geo_districts_on_country_code"
  add_index "geo_districts", ["region_id"], name: "index_geo_districts_on_region_id"

  create_table "geo_regions", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "country_code", limit: 2
  end

  add_index "geo_regions", ["code"], name: "index_geo_regions_on_code"
  add_index "geo_regions", ["country_code"], name: "index_geo_regions_on_country_code"

end
