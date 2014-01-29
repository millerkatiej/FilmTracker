class Title
  attr_accessor :name, :director, :year, :country
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
  end

  def self.create(attributes = {})
    title = Title.new(attributes)
    title.save
    title
  end

  def update attributes = {}
    update_attributes(attributes)
    save
  end

  def save
    database = Environment.database_connection
    if id
      database.execute("update titles set name = '#{name}', director = '#{director}', year = '#{year}', country = '#{country}' where id = #{id}")
    else
      database.execute("insert into titles(name, director, year, country) values('#{name}', #{director}, #{year}, #{country})")
      @id = database.last_insert_row_id
    end
    # ^ fails silently!!
    # ^ Also, susceptible to SQL injection!
  end

  def self.find id
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from titles where id = #{id}")[0]
    if results
      title = Title.new(name: results["name"], director: results["director"], year: results["year"], country: results["country"])
      title.send("id=", results["id"])
      title
    else
      nil
    end
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from titles order by name ASC")
    results.map do |row_hash|
      title = Title.new(name: row_hash["name"], director: row_hash["director"], year: row_hash["year"], country: row_hash["country"])
      title.send("id=", row_hash["id"])
      title
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