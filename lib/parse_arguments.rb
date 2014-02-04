require 'optparse'

class ParseArguments
	def self.parse
		options = { environment: "production" }
		OptionParser.new do |opts|
		  opts.banner = "Usage: filmtracker [command] [options]"

		  opts.on("--director [DIRECTOR]", "The director") do |director|
		    options[:director] = director
		  end

		  opts.on("--year [YEAR]", "The year") do |year|
		    options[:year] = year
		  end

		  opts.on("--country [COUNTRY]", "The country of origin") do |country|
		    options[:country] = country
		  end

		  opts.on("--id [ID]", "The id of the object we are editing") do |id|
       	options[:id] = id
      end

      opts.on("--name [NAME]", "The name of the film") do |name|
        options[:name] = name
      end

      opts.on("--environment [ENV]", "The database environment") do |env|
        options[:environment] = env
      end

      opts.on("--language [LANG]", "The database language") do |lang|
        options[:language] = lang
      end
			
			opts.on("--distributor [DIST]", "The database distributor") do |dist|
        options[:distributor] = dist
      end

			opts.on("--date [DATE]", "The database date") do |date|
        options[:date] = date
      end

			opts.on("--rating [RATING]", "The database rating") do |rating|
        options[:rating] = rating
      end

			opts.on("--format [FORMAT]", "The database format") do |format|
        options[:format] = format
      end

			opts.on("--notes [NOTES]", "The database notes") do |notes|
        options[:notes] = notes
      end

		end.parse!
		options
	end

	def self.validate options
		errors = []
		if options[:name].nil? or options[:name].empty?
		  puts "You must provide the name of the film you are adding."
			exit
		end

		missing_things = []
		missing_things << "year" unless options[:year]
		missing_things << "director" unless options[:director]
		missing_things << "country of origin" unless options[:country]
		missing_things << "language" unless options[:language]
		missing_things << "distributor or type Unknown" unless options[:distributor]
		missing_things << "date viewed" unless options[:date]
		missing_things << "rating" unless options[:rating]
		missing_things << "format" unless options[:format]


		unless missing_things.empty?
		  errors << "You must provide the #{missing_things.join(" and ")} of the film you are adding."  
		end
		errors
	end
end