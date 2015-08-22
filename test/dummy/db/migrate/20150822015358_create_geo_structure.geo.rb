# This migration comes from geo (originally 20150822013245)
class CreateGeoStructure < ActiveRecord::Migration
  def change
    create_table "geo_cities", force: :cascade do |t|
      t.string  "name"
      t.string  "country_code", limit: 2
      t.integer "region_id"
      t.integer "district_id"
      t.float   "latitude"
      t.float   "longitude"
    end

    add_index "geo_cities", ["country_code"]

    create_table "geo_continents", id: false, force: :cascade do |t|
      t.string "code", limit: 2
      t.string "name"
    end

    add_index "geo_continents", ["code"]

    create_table "geo_countries", id: false, force: :cascade do |t|
      t.string "code",           limit: 2
      t.string "name"
      t.string "continent_code", limit: 2
    end

    add_index "geo_countries", ["code"]
    add_index "geo_countries", ["continent_code"]

    create_table "geo_districts", force: :cascade do |t|
      t.string  "code"
      t.string  "country_code"
      t.string  "name"
      t.integer "region_id"
    end

    add_index "geo_districts", ["code"]
    add_index "geo_districts", ["country_code"]
    add_index "geo_districts", ["region_id"]

    create_table "geo_regions", force: :cascade do |t|
      t.string "code"
      t.string "name"
      t.string "country_code", limit: 2
    end

    add_index "geo_regions", ["code"]
    add_index "geo_regions", ["country_code"]
  end
end
