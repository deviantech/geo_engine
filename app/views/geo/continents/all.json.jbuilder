json.array! @continents do |continent|
  json.(continent, :code, :name)

  json.countries continent.countries do |country|
    json.(country, :code, :name)

    json.regions country.regions do |region|
      json.(region, :id, :code, :name)

      json.districts region.districts do |district|
        json.(district, :id, :name)
      end
    end

    json.cities country.cities do |city|
        json.(city, :id, :name, :region_id, :district_id)

        if params[:full]
          json.(city, :latitude, :longitude)
        end
      end
  end
end