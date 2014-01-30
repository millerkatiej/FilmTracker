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
Persona: director: Ingmar Bergman, year: 1966, country: Sweden, id: #{persona.id}
The Third Generation: director: Rainer Werner Fassbinder, year: 1975, country: Germany, id: #{the_third_generation.id}
Irma Vep: director: Olivier Assayas, year: 1996, country: France, id: #{irma_vep.id}
EOS
    assert_command_output expected, command
  end
end