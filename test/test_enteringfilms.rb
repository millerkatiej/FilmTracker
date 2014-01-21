require_relative 'helper'

class TestEnteringFilms < MiniTest::Unit::TestCase
	def test_valid_purchase_information_gets_printed
	    command = "./filmtracker add Persona --title Persona --director 'Ingmar Bergman'"
	    expected = "Theoretically creating: a film titled Persona, by director Ingmar Bergman"
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

	def test_error_message_for_missing_title
		command = "./filmtracker add"
		expected = "You must provide the title of the film you are adding."
		assert_command_output expected, command
	end

	def test_error_message_for_missing_director
		command = "./filmtracker add"
		expected = "You must provide the name of the director you are adding."
		assert_command_output expected, command
	end





end