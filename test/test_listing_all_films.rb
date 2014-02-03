require_relative 'helper'

class TestListingFilms < FilmTest
  def test_list_returns_relevant_results
    # create will be new+save
    persona = Film.create(name: "Persona", director: 'Ingmar Bergman', year: 1966, country: "Sweden")
    the_third_generation = Film.create(name: "The Third Generation", director: 'Rainer Werner Fassbinder', year: 1975, country: "Germany")
    irma_vep = Film.create(name: "Irma Vep", director: 'Olivier Assayas', year: 1996, country: "France")

    command = "./filmtracker list"
    expected = <<EOS.chomp
All Films:
Irma Vep: Olivier Assayas, 1996, France, #{irma_vep.id}
Persona: Ingmar Bergman, 1966, Sweden, #{persona.id}
The Third Generation: Rainer Werner Fassbinder, 1975, Germany, #{the_third_generation.id}
EOS
    assert_command_output expected, command
  end
end