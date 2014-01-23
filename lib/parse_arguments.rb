require 'optparse'

class ParseArguments
	def self.parse
		options = {}
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
		unless missing_things.empty?
		  errors << "You must provide the #{missing_things.join(" and ")} of the film you are adding."  
		end
		errors
	end
end