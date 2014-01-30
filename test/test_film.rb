require_relative 'helper'
require_relative '../models/film'

class TestFilm < FilmTest
  def test_to_s_prints_details
    film = Film.new(name: "Foo", director: "Bar", year: "666", country: "Bash")
    expected = "Foo: director: Bar, year: 666, country: Bash, id: #{film.id}"
    assert_equal expected, film.to_s
  end

  def test_update_doesnt_insert_new_row
    film = Film.new(name: "Foo", director: "Bar", year: "666", country: "Bash")
    foos_before = database.execute("select count(id) from films")[0][0]
    film.update(name: "Baz")
    foos_after = database.execute("select count(id) from films")[0][0]
    assert_equal foos_before, foos_after
  end

  def test_update_saves_to_the_database
    film = Film.new(name: "Foo", director: "Bar", year: "666", country: "Bash")
    id = film.id
    film.update(name: "Baz", director: "Katie", year: "999", country: "USA")
    updated_film = Film.find(id)
    expected = ["Baz", "Katie", 999, "USA" ]
    actual = [ updated_film.name, updated_film.director, updated_film.year, updated_film.country]
    assert_equal expected, actual
  end

  def test_update_is_reflected_in_existing_instance
    film = Film.new(name: "Foo", director: "Bar", year: "666", country: "Bash")
    film.update(name: "Baz", director: "Katie", year: "999", country: "USA")
    expected = ["Baz", "Katie", "999", "USA" ]
    actual = [ film.name, film.director, film.year, film.country ]
    assert_equal expected, actual
  end

  def test_saved_films_are_saved
    film = Film.new(name: "Foo", director: "Bar", year: "666", country: "Bash")
    foos_before = database.execute("select count(id) from films")[0][0]
    film.save
    foos_after = database.execute("select count(id) from films")[0][0]
    assert_equal foos_before + 1, foos_after
  end

  def test_save_creates_an_id
    film = Film.new(name: "Foo", director: "Bar", year: "666", country: "Bash")
    refute_nil film.id, "Film id shouldn't be nil"
  end

  def test_find_returns_nil_if_unfindable
    assert_nil Film.find(12342)
  end

  def test_find_returns_the_row_as_film_object
    film = Film.new(name: "Foo", director: "Bar", year: "666", country: "Bash")
    found = Film.find(film.id)
    # Ideally: assert_equal film, found
    # Hacky way so that we can focus on today's material:
    assert_equal film.name, found.name
    assert_equal film.id, found.id
  end

  def test_all_returns_all_films_in_alphabetical_order
    film = Film.new(name: "Foo", director: "Bar", year: "666", country: "Bash")
    film = Film.new(name: "Miller", director: "Katie", year: "999", country: "USA")
    results = Film.all
    expected = ["Foo", "Miller"]
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