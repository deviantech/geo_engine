module Geo
  class ApplicationController < ActionController::Base

    include Geo::SharedControllerConcerns

    def index
      respond_with @continents
    end

    def all
      @continents = @continent_base.includes({countries: {regions: :cities}})
    end

  end
end