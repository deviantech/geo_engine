require_dependency "geo/application_controller"

module Geo
  class CitiesController < ApplicationController

    def index
      respond_with @cities
    end

  end
end