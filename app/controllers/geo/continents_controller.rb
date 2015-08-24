require_dependency "geo/application_controller"

module Geo
  class ContinentsController < ApplicationController

    def index
      respond_with @continents
    end

    def all
      @continents = @continent_base.includes({countries: {regions: :cities}})
    end

  end
end