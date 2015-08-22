module Geo
  class Country < ActiveRecord::Base
    self.primary_key = 'code'

    belongs_to :continent, foreign_key: :continent_code
    has_many :regions, foreign_key: :country_code
    has_many :districts, foreign_key: :country_code
    has_many :cities, foreign_key: :country_code

    default_scope { order('code asc') }
  end
end