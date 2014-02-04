require_relative 'helper'

class TestEditingFilms < FilmTest
  def test_updating_a_record_that_exists
    film = Film.new(name: "Persona", director: "Ingmar Bergman", year: 1966, country: "Sweden", language: "Swedish", distributor: "MGM Home Entertainment", date: "12/17/13", format: "DVD", rating: 9, notes: "Loved it")
    film.save
    id = film.id
    command = "./filmtracker edit --id #{id} --name Persona --year 1967 --director 'Ingmar Bergman' --country 'Sweden' --language 'Swedish' --distributor 'MGM Home Entertainment' --date '12/17/13' --format DVD --rating 9 --notes 'Loved it' --environment test"
    expected = "Film #{id} is now named Persona, released in 1967, directed by Ingmar Bergman, from Sweden, in Swedish, distributed by MGM Home Entertainment, viewed on 12/17/13, with a viewing format of DVD, given a personal rating of 9, and the following notes: Loved it."
    # What about the db?
    assert_command_output expected, command
  end

  def test_attempting_to_update_a_nonexistant_record
    command = "./filmtracker edit --id 218903123980123 --name Persona --year 1966 --director 'Ingmar Bergman' --country Sweden --environment test"
    expected = "Film 218903123980123 couldn't be found."
    assert_command_output expected, command
  end

  def test_attempting_to_update_with_no_changes
    film = Film.new(name: "Persona", director: "Ingmar Bergman", year: 1966, country: "Sweden", language: "Swedish", distributor: "MGM Home Entertainment", date: "12/17/13", format: "DVD", rating: 9, notes: "Loved it")
    film.save
    id = film.id
    command = "./filmtracker edit --id #{id} --name Persona --year 1966 --director 'Ingmar Bergman' --country 'Sweden' --language 'Swedish' --distributor 'MGM Home Entertainment' --date '12/17/13' --format DVD --rating 9 --notes 'Loved it' --environment test"
    expected = "Film #{id} is now named Persona, released in 1966, directed by Ingmar Bergman, from Sweden, in Swedish, distributed by MGM Home Entertainment, viewed on 12/17/13, with a viewing format of DVD, given a personal rating of 9, and the following notes: Loved it."
    assert_command_output expected, command
  end

  def test_attempting_to_update_with_bad_data
    skip
    film = Film.new(name: "Persona", director: "Ingmar Bergman", year: 1966, country: "Sweden", language: "Swedish", distributor: "MGM Home Entertainment", date: "12/17/13", format: "DVD", rating: 9, notes: "Loved it")
    film.save
    id = film.id #<--- First thing we have to implement
    command = "./filmtracker edit --id #{id} --name Persona --year nineteensixtysix --director 'Ingmar Bergman' --country Sweden"
    expected = "Film #{id} can't be updated.  Year must be a number."
    assert_command_output expected, command
  end

  def test_attempting_to_update_partial_data
    
    film = Film.new(name: "Persona", director: "Ingmar Bergman", year: 1966, country: "Sweden", language: "Swedish", distributor: "MGM Home Entertainment", date: "12/17/13", format: "DVD", rating: 9, notes: "Loved it")
    film.save
    id = film.id #<--- First thing we have to implement
    command = "./filmtracker edit --id #{id} --year 1967"
    expected = "Film #{id} is now named Persona, released in 1967, directed by Ingmar Bergman, from Sweden, in Swedish, distributed by MGM Home Entertainment, viewed on 12/17/13, with a viewing format of DVD, given a personal rating of 9, and the following notes: Loved it."
    assert_command_output expected, command
  end
end