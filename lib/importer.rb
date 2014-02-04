require 'csv'

class Importer
  def self.import(from_filename)
    CSV.foreach(from_filename, headers: true) do |row_hash|
      import_film(row_hash)
    end
  end

  def self.import_film(row_hash)
    film = Film.create(
      name: row_hash["name"],
      director: row_hash["director"], 
      year: row_hash["year"].to_i, 
      country: row_hash["country"], 
      language: row_hash["language"], 
      distributor: row_hash["distributor"], 
      date: row_hash["date"], 
      format: row_hash["format"], 
      rating: row_hash["rating"].to_i, 
      notes: row_hash["notes"]
    )
  end
end