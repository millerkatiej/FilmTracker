require_relative 'helper'

class TestFilm < FilmTest
  def test_to_s_prints_details
    film = Film.new(name: "The Third Generation", director: 'Rainer Werner Fassbinder', year: 1975, country: "Germany", language: "German", distributor: "Unknown", date: "12/09/13", format: "DVD", rating: 7, notes: "Great political commentary, very absurdist")
    expected = "The Third Generation: Rainer Werner Fassbinder, 1975, Germany, German, Unknown, 12/09/13, DVD, 7, Great political commentary, very absurdist, #{film.id}"
    assert_equal expected, film.to_s
  end

  def test_update_doesnt_insert_new_row
    film = Film.create(name: "The Third Generation", director: 'Rainer Werner Fassbinder', year: 1975, country: "Germany", language: "German", distributor: "Unknown", date: "12/09/13", format: "DVD", rating: 7, notes: "Great political commentary, very absurdist")
    foos_before = database.execute("select count(id) from films")[0][0]
    film.update(name: "The 3rd Generation")
    foos_after = database.execute("select count(id) from films")[0][0]
    assert_equal foos_before, foos_after
  end

  def test_update_saves_to_the_database
    film = Film.create(name: "Persona", director: "Ingmar Bergman", year: 1966, country: "Sweden", language: "Swedish", distributor: "MGM Home Entertainment", date: "12/17/13", format: "DVD", rating: 9, notes: "Loved it")
    id = film.id
    film.update(name: "My Movie", director: "Katie Miller", year: 1999, country: "USA", language: "English", distributor: "Criterion Collection", date: "12/17/14", format: "Theater", rating: 7, notes: "Loved it a lot")
    updated_film = Film.find(id)
    expected = ["My Movie", "Katie Miller", 1999, "USA", "English", "Criterion Collection", "12/17/14", "Theater", 7, "Loved it a lot" ]
    actual = [ updated_film.name, updated_film.director, updated_film.year, updated_film.country, updated_film.language, updated_film.distributor, updated_film.date, updated_film.format, updated_film.rating, updated_film.notes]
    assert_equal expected, actual
  end

  def test_update_is_reflected_in_existing_instance
    film = Film.create(name: "Persona", director: "Ingmar Bergman", year: 1966, country: "Sweden", language: "Swedish", distributor: "MGM Home Entertainment", date: "12/17/13", format: "DVD", rating: 9, notes: "Loved it")
    film.update(name: "My Movie", director: "Katie Miller", year: 1999, country: "USA", language: "English", distributor: "Criterion Collection", date: "12/17/14", format: "Theater", rating: 7, notes: "Loved it a lot")
    expected = ["My Movie", "Katie Miller", 1999, "USA", "English", "Criterion Collection", "12/17/14", "Theater", 7, "Loved it a lot"]
    actual = [ film.name, film.director, film.year, film.country, film.language, film.distributor, film.date, film.format, film.rating, film.notes ]
    assert_equal expected, actual
  end

  def test_saved_films_are_saved
    foos_before = database.execute("select count(id) from films")[0][0]
    film = Film.create(name: "Persona", director: "Ingmar Bergman", year: 1966, country: "Sweden", language: "Swedish", distributor: "MGM Home Entertainment", date: "12/17/13", format: "DVD", rating: 9, notes: "Loved it")
    film.save
    foos_after = database.execute("select count(id) from films")[0][0]
    assert_equal foos_before + 1, foos_after
  end

  def test_save_creates_an_id
    film = Film.create(name: "Foo", director: "Bar", year: "666", country: "Bash")
    refute_nil film.id, "Film id shouldn't be nil"
  end

  def test_find_returns_nil_if_unfindable
    assert_nil Film.find(12342)
  end

  def test_find_returns_the_row_as_film_object
    film = Film.create(name: "Foo", director: "Bar", year: "666", country: "Bash")
    found = Film.find(film.id)
    # Ideally: assert_equal film, found
    # Hacky way so that we can focus on today's material:
    assert_equal film.name, found.name
    assert_equal film.id, found.id
  end

  def test_all_returns_all_films_in_alphabetical_order
    Film.create(name: "The Third Generation", director: 'Rainer Werner Fassbinder', year: 1975, country: "Germany", language: "German", distributor: "Unknown", date: "12/09/13", format: "DVD", rating: 7, notes: "Great political commentary, very absurdist")
    Film.create(name: "Persona", director: "Ingmar Bergman", year: 1966, country: "Sweden", language: "Swedish", distributor: "MGM Home Entertainment", date: "12/17/13", format: "DVD", rating: 9, notes: "Loved it")
    results = Film.all
    expected = ["Persona", "The Third Generation"]
    actual = results.map{ |film| film.name }
    # ^ is equivalent to:
    # actual = []
    # results.each do |film|
    #   actual << film.name
    # end
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_films
    results = Film.all
    assert_equal [], results
  end
end