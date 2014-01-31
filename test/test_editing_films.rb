require_relative 'helper'

class TestEditingFilms < FilmTest
  def test_updating_a_record_that_exists
    film = Film.new(name: "Persona", director: "Ingmar Bergman", year: 1966, country: "Sweden")
    film.save
    id = film.id
    command = "./filmtracker edit --id #{id} --name Persona --year 1967 --director 'Ingmar Bergman' --country Sweden"
    expected = "Film #{id} is now named Persona, with Ingmar Bergman as director, released in 1967 from Sweden."
    # What about the db?
    assert_command_output expected, command
  end

  def test_attempting_to_update_a_nonexistant_record
    command = "./filmtracker edit --id 218903123980123 --name Persona --year 1966 --director 'Ingmar Bergman' --country Sweden"
    expected = "Film 218903123980123 couldn't be found."
    assert_command_output expected, command
  end

  def test_attempting_to_update_with_no_changes
    film = Film.new(name: "Persona", director: "Ingmar Bergman", year: 1966, country: "Sweden")
    film.save
    id = film.id
    command = "./filmtracker edit --id #{id} --name Persona --year 1966 --director 'Ingmar Bergman' --country Sweden"
    expected = "Film #{id} is now named Persona, with Ingmar Bergman as director, released in 1966 from Sweden."
    assert_command_output expected, command
  end

  def test_attempting_to_update_with_bad_data
    skip
    film = Film.new(name: "Persona", director: "Ingmar Bergman", year: 1966, country: "Sweden")
    film.save
    id = film.id #<--- First thing we have to implement
    command = "./filmtracker edit --id #{id} --name Persona --year nineteensixtysix --director 'Ingmar Bergman' --country Sweden"
    expected = "Film #{id} can't be updated.  Year must be a number."
    assert_command_output expected, command
  end

  def test_attempting_to_update_partial_data
    skip
    film = Film.new(name: "Persona", director: "Ingmar Bergman", year: 1966, country: "Sweden")
    film.save
    id = film.id #<--- First thing we have to implement
    command = "./filmtracker edit --id #{id} --name Persona"
    expected = "Film #{id} is now named Persona, with Ingmar Bergman as director, released in 1966 from Sweden."
    assert_command_output expected, command
  end
end