module Geo
  class Continent < ActiveRecord::Base
    self.primary_key = 'code'

    has_many :countries, foreign_key: :continent_code
    has_many :regions, through: :countries
    has_many :districts, through: :countries
    has_many :cities,  through: :countries

    default_scope { order('name asc') }
  end
end
