require_relative 'helper'

class TestEnteringFilms < FilmTest
	def test_valid_purchase_information_gets_printed
	    command = "./filmtracker add Persona --year 1966 --director 'Ingmar Bergman' --country 'Sweden' --language 'Swedish' --distributor 'MGM Home Entertainment' --date '12/17/13' --format DVD --rating 9 --notes 'Loved it' --environment test"
	    expected = "You have created a film named Persona, released in 1966, directed by Ingmar Bergman, from Sweden, in Swedish, distributed by MGM Home Entertainment, viewed on 12/17/13, with a viewing format of DVD, given a personal rating of 9, and the following notes: Loved it."
	    assert_command_output expected, command
	end

	def test_valid_film_saved
	`./filmtracker add Persona --year 1966 --director 'Ingmar Bergman' --country Sweden --language 'Swedish' --distributor 'MGM Home Entertainment' --date '12/17/13' --format DVD --rating 9 --notes 'Loved it' --environment test`
    results = database.execute("SELECT name, director, year, country, language, distributor, date, format, rating, notes FROM films")
    expected = ["Persona", "Ingmar Bergman", 1966, "Sweden", "Swedish", "MGM Home Entertainment", "12/17/13", "DVD", 9, "Loved it"]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from films")
    assert_equal 1, result[0][0]
	end

	def test_invalid_film_not_saved
		`./filmtracker add Persona --director 'Ingmar Bergman --environment test'`
    	result = database.execute("select count(id) from films")
    	assert_equal 0, result[0][0]
	end

  	def test_error_message_for_missing_name
	    command = "./filmtracker add --year 1966 --director 'Ingmar Bergman' --country Sweden --language 'Swedish' --distributor 'MGM Home Entertainment' --date '12/17/13' --format DVD --rating 9 --notes 'Loved it' --environment test"
	    expected = "You must provide the name of the film you are adding."
	    assert_command_output expected, command
  	end

	def test_error_message_for_missing_director
	    command = "./filmtracker add Persona --year 1966 --country Sweden --language 'Swedish' --distributor 'MGM Home Entertainment' --date '12/17/13' --format DVD --rating 9 --notes 'Loved it' --environment test"
		expected = "You must provide the director of the film you are adding."
		assert_command_output expected, command
	end

	def test_error_message_for_missing_year
	    command = "./filmtracker add Persona --director 'Ingmar Bergman' --country Sweden --language 'Swedish' --distributor 'MGM Home Entertainment' --date '12/17/13' --format DVD --rating 9 --notes 'Loved it' --environment test"
		expected = "You must provide the year of the film you are adding."
		assert_command_output expected, command
	end

	def test_error_message_for_missing_country_of_origin
	    command = "./filmtracker add Persona --year 1966 --director 'Ingmar Bergman' --language 'Swedish' --distributor 'MGM Home Entertainment' --date '12/17/13' --format DVD --rating 9 --notes 'Loved it' --environment test"
		expected = "You must provide the country of origin of the film you are adding."
		assert_command_output expected, command
	end

	def test_error_message_for_missing_year_and_director
	    command = "./filmtracker add Persona --country Sweden --language 'Swedish' --distributor 'MGM Home Entertainment' --date '12/17/13' --format DVD --rating 9 --notes 'Loved it' --environment test"
	    expected = "You must provide the year and director of the film you are adding."
	    assert_command_output expected, command
	end
		
	def test_error_message_for_missing_director_and_country
	    command = "./filmtracker add Persona --year 1966 --language 'Swedish' --distributor 'MGM Home Entertainment' --date '12/17/13' --format DVD --rating 9 --notes 'Loved it' --environment test"
	    expected = "You must provide the director and country of origin of the film you are adding."
	    assert_command_output expected, command
	end


end