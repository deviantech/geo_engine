module Geo
  module SharedControllerConcerns
    extend ActiveSupport::Concern

    included do
      respond_to :json
      before_filter :load_scopes
    end

    private

    def load_scopes
      @continent_base = Continent
      @continents     = @continent_base.all
      @continent      = if (v = params[:continent_id]).present?
        @continent_base.where(code: v).first || @continent_base.find(v)
      end

      @country_base = @continent ? @continent.countries : Country
      @countries    = @country_base.all
      @country      = if (v = params[:country_id]).present?
        @country_base.where(code: v).first || @country_base.find(v)
      end

      @region_base = @country ? @country.regions : (@continent ? @continent.regions : Region)
      @regions     = @region_base.all
      @region      = if (v = params[:region_id]).present?
        @region_base.where(code: v).first || @region_base.find(v)
      end

      @district_base = @region ? @region.districts : (@country ? @country.districts : (@continent ? @continent.districts : District))
      @districts     = @district_base.all
      @district      = if (v = params[:district_id]).present?
        @district_base.find(v)
      end

      @city_base   = @district ? @district.cities : (@region ? @region.cities : (@country ? @country.cities : (@continent ? @continent.cities : City)))
      @cities      = @city_base.all
      @city        = if (v = params[:city_id]).present?
        @city_base.find(v)
      end
    end

  end
end