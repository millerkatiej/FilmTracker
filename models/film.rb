class Film
  attr_accessor :name, :director, :year, :country
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
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
      database.execute("update films set name = '#{name}', director = '#{director}', year = '#{year}', country = '#{country}' where id = #{id}")
    else
      database.execute("insert into films(name, director, year, country) values('#{name}', #{director}, #{year}, #{country})")
      @id = database.last_insert_row_id
    end
    # ^ fails silently!!
    # ^ Also, susceptible to SQL injection!
  end

  def self.find id
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from films where id = #{id}")[0]
    if results
      film = Film.new(name: results["name"], director: results["director"], year: results["year"], country: results["country"])
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
      film = Film.new(name: row_hash["name"], director: row_hash["director"], year: row_hash["year"], country: row_hash["country"])
      film.send("id=", row_hash["id"])
      film
    end
  end

  # def price
  #   sprintf('%.2f', @price) if @price
  # end

  def to_s
    "#{name}: #{director} , #{year}, #{country}, id: #{id}"
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
    [:name, :director, :year, :country].each do |attr|
      if attributes[attr]
        # self.calories = attributes[:calorie]
        self.send("#{attr}=", attributes[attr])
      end
    end
  end
end