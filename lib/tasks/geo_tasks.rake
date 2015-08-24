namespace :geo do

  namespace :import do

    def city_zip; 'tmp/geo/cities.zip'; end
    def city_raw; 'tmp/geo/cities15000.txt'; end
    def country_raw; 'tmp/geo/countryInfo.txt'; end
    def region_raw; 'tmp/geo/regions.txt'; end
    def district_raw; 'tmp/geo/districts.txt'; end

    def import_for(klass)
      name  = klass.name.split('::').last
      file  = send("#{name.downcase}_raw")
      total = `wc -l #{file}`.strip.to_i
      bar   = ProgressBar.create title: name, total: total, format: "%a %e %P% #{name} Processed: %c from %C"
      klass.delete_all

      IO.foreach(file) do |line|
        next if line.starts_with?('#')
        data = line.chomp.split("\t")
        yield(data)
        bar.increment
      end
    end

    task download: :environment do
      FileUtils.mkdir_p( File.dirname(city_zip) )

      unless File.exists?(city_raw)
        `curl -o #{city_zip} http://download.geonames.org/export/dump/cities15000.zip` unless File.exists?(city_zip)
        `cd #{File.dirname(city_zip)} && unzip #{File.basename(city_zip)}`
      end

      `curl -o #{country_raw} http://download.geonames.org/export/dump/countryInfo.txt` unless File.exists?(country_raw)

      `curl -o #{region_raw} http://download.geonames.org/export/dump/admin1CodesASCII.txt` unless File.exists?(region_raw)

      `curl -o #{district_raw} http://download.geonames.org/export/dump/admin2Codes.txt` unless File.exists?(district_raw)
    end

    task continents: :environment do
      Geo::Continent.delete_all

      {AF: 'Africa', AS: 'Asia', EU: 'Europe', NA: 'North America', OC: 'Oceania', SA: 'South America', AN: 'Antarctica'}.each do |code, name|
        Geo::Continent.create! code: code, name: name
      end
    end

    task countries: [:download, :continents] do
      import_for( Geo::Country ) do |data|
        Geo::Country.create!({
          code: data[0],
          name: data[4],
          continent_code: data[8]
        })
      end
    end

    task regions: :countries do
      Geo::District.delete_all
      import_for( Geo::Region ) do |data|
        country_code, region_code = data[0].split('.')
        region_name = data[2]

        Geo::Region.create!(code: region_code, country_code: country_code, name: region_name)
      end
    end

    task districts: :regions do
      import_for( Geo::District ) do |data|
        country_code, region_code, district_code = data[0].split('.')

        if region = Geo::Region.find_by(country_code: country_code, code: region_code)
          region.districts.create!(code: district_code, name: data[2], country_code: country_code)
        else
          puts "District #{data[2]} (code '#{district_code}') - Found no matching region for '#{region_code}' in country #{country_code}\n"
        end
      end
    end

    task cities: [:regions, :districts] do
      # g.geonameid = data[0]
      # g.name = data[1]
      # g.asciiname = data[2]
      # g.alternatenames = data[3]
      # g.latitude = data[4]
      # g.longitude = data[5]
      # g.feature = data[6]
      # g.feature_code = data[7]
      # g.country_code = data[8]
      # g.cc2 = data[9]
      # g.admin1 = data[10]
      # g.admin2 = data[11]
      # g.admin3 = data[12]
      # g.admin4 = data[13]
      # g.population = data[14]
      # g.elevation = data[15]
      # g.gtopo30 = data[16]
      # g.timezone = data[17]
      # g.modification_date = Time.parse(data[18])
      import_for( Geo::City ) do |data|
        country_code, region_code, district_code = data[8], data[10], data[11]

        unless region = Geo::Region.find_by(code: region_code, country_code: country_code)
          puts "#{data[2]} - Found no matching region for '#{region_code}' in country #{country_code}\n"
        end

        district_base = region ? region.districts : Geo::District
        unless district_code.blank?
          unless district = district_base.find_by(code: district_code, country_code: country_code)
            puts "#{data[2]} - Found no matching district for '#{district_code}' in country #{country_code} (region: #{region_code})\n"
          end
        end

        Geo::City.create!({
          region_id: region.try(:id),
          district_id: district.try(:id),
          name: data[2],
          latitude: data[4],
          longitude: data[5],
          country_code: country_code
        })
      end
    end

    task all: [:download, :continents, :countries, :regions, :districts, :cities] do
    end

  end

end