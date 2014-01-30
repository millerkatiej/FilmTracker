require_relative 'helper'

class TestEnteringFilms < FilmTest
	def test_valid_purchase_information_gets_printed
	    command = "./filmtracker add Persona --year 1966 --director 'Ingmar Bergman' --country Sweden"
	    expected = "You have created a film named Persona, released in 1966 and directed by Ingmar Bergman from Sweden."
	    assert_command_output expected, command
	end

	def test_valid_film_saved
	`./filmtracker add Persona --director 'Ingmar Bergman' --year 1966 --country Sweden`
    results = database.execute("select name, director, year, country from films")
    expected = ["Persona", "Ingmar Bergman", 1966, "Sweden"]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from films")
    assert_equal 1, result[0][0]
	end

	def test_invalid_film_not_saved
		`./filmtracker add Persona --director 'Ingmar Bergman'`
    	result = database.execute("select count(id) from films")
    	assert_equal 0, result[0][0]
	end

  	def test_error_message_for_missing_name
	    command = "./filmtracker add"
	    expected = "You must provide the name of the film you are adding."
	    assert_command_output expected, command
  	end

	def test_error_message_for_missing_director
		command = "./filmtracker add Persona --year 1966 --country Sweden"
		expected = "You must provide the director of the film you are adding."
		assert_command_output expected, command
	end

	def test_error_message_for_missing_year
		command = "./filmtracker add Persona --director Ingmar Bergman --country Sweden"
		expected = "You must provide the year of the film you are adding."
		assert_command_output expected, command
	end

	def test_error_message_for_missing_country_of_origin
		command = "./filmtracker add Persona --year 1966 --director Ingmar Bergman"
		expected = "You must provide the country of origin of the film you are adding."
		assert_command_output expected, command
	end

	def test_error_message_for_missing_year_and_director
	    command = "./filmtracker add Persona --country Sweden"
	    expected = "You must provide the year and director of the film you are adding."
	    assert_command_output expected, command
	end
		
	def test_error_message_for_missing_director_and_country
	    command = "./filmtracker add Persona --year 1966"
	    expected = "You must provide the director and country of origin of the film you are adding."
	    assert_command_output expected, command
	end


end