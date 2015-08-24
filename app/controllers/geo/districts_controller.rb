require_dependency "geo/application_controller"

module Geo
  class DistrictsController < ApplicationController

    def index
      respond_with @districts
    end

  end
end