require_dependency "geo/application_controller"

module Geo
  class RegionsController < ApplicationController

    def index
      respond_with @regions
    end

  end
end