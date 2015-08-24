require_dependency "geo/application_controller"

module Geo
  class CountriesController < ApplicationController

    def index
      respond_with @countries
    end

  end
end