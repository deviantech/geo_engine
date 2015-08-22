module Geo
  class City < ActiveRecord::Base
    belongs_to :region
    belongs_to :district
    belongs_to :country, foreign_key: :country_code

    validates :country, presence: true
  end
end