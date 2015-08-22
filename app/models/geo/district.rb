module Geo
  class District < ActiveRecord::Base
    belongs_to :country, foreign_key: :country_code
    belongs_to :region
    has_many :cities

    validates :country, :region, presence: true
  end
end