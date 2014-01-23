require_relative 'helper'

class TestEnteringFilms < MiniTest::Unit::TestCase
	def test_valid_purchase_information_gets_printed
	    command = "./filmtracker add Persona --year 1966 --director 'Ingmar Bergman' --country Sweden"
	    expected = "Theoretically creating: a film named Persona, released in 1966 and directed by Ingmar Bergman from Sweden."
	    assert_command_output expected, command
	end
	def test_valid_film_saved
		skip "test valid film saved"
		assert false
	end

	def test_invalid_film_not_saved
		skip "test valid film not saved"
		assert false
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
		command = "./filmtracker add Persona --director 'Ingmar Bergman' --country Sweden"
		expected = "You must provide the year of the film you are adding."
		assert_command_output expected, command
	end

	def test_error_message_for_missing_country_of_origin
		command = "./filmtracker add Persona --year 1966 --director 'Ingmar Bergman'"
		expected = "You must provide the country of origin of the film you are adding."
		assert_command_output expected, command
	end

	def test_error_message_for_missing_year_and_director
	    command = "./filmtracker add Persona --country Sweden"
	    expected = "You must provide the year and director of the film you are adding."
	    assert_command_output expected, command
	end
	


end