require 'pry'
class Film
  attr_accessor :name, :director, :year, :country, :language, :distributor, :date, :format, :rating, :notes
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
  end

  def year=(year)
    @year = year.to_i
  end

  def rating=(rating)
    @rating = rating.to_i
  end

  def self.create(attributes = {})
    film = Film.new(attributes)
    film.save
    film
  end

  def update attributes = {}
    update_attributes(attributes)
    save
  end

  def save
    database = Environment.database_connection
    if id
      database.execute("update films set name = '#{name}', director = '#{director}', year = #{year.to_i}, country = '#{country}', language = '#{language}', distributor = '#{distributor}', date = '#{date}', format = '#{format}', rating = #{rating.to_i}, notes = '#{notes}' where id = #{id}")
    else
      database.execute("insert into films(name, director, year, country, language, distributor, date, format, rating, notes) values('#{name}', '#{director}', #{year.to_i}, '#{country}', '#{language}', '#{distributor}', '#{date}', '#{format}', #{rating.to_i}, '#{notes}')")
      @id = database.last_insert_row_id
    end
  end

  def self.find id
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from films where id = #{id}")[0]
    if results
      film = Film.new(name: results["name"], director: results["director"], year: results["year"], country: results["country"], language: results["language"], distributor: results["distributor"], date: results["date"], format: results["format"], rating: results["rating"], notes: results["notes"])
      film.send("id=", results["id"])
      film
    else
      nil
    end
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from films order by name ASC")
    results.map do |row_hash|
      film = Film.new(name: row_hash["name"], director: row_hash["director"], year: row_hash["year"], country: row_hash["country"], language: row_hash["language"], distributor: row_hash["distributor"], date: row_hash["date"], format: row_hash["format"], rating: row_hash["rating"], notes: row_hash["notes"])
      film.send("id=", row_hash["id"])
      film
    end
  end

  # def price
  #   sprintf('%.2f', @price) if @price
  # end

  def to_s
    "#{name}: #{director}, #{year}, #{country}, #{language}, #{distributor}, #{date}, #{format}, #{rating}, #{notes}, #{id}"
  end

  protected

  def id=(id)
    @id = id
  end

  def update_attributes(attributes)
    # @price = attributes[:price]
    # @calories = attributes[:calories]
    # @name = attributes[:name]
    # ^ Long way
    # Short way:
    [:name, :director, :year, :country, :language, :distributor, :date, :rating, :format, :notes].each do |attr|
      if attributes[attr]
        # self.calories = attributes[:calorie]
        self.send("#{attr}=", attributes[attr])
      end
    end
  end
end