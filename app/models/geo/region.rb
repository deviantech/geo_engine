module Geo
  class Region < ActiveRecord::Base
    belongs_to :country, foreign_key: :country_code
    has_many :districts
    has_many :cities

    validates :country, presence: true
  end
end