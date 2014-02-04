require_relative 'helper'

class TestListingFilms < FilmTest
  def test_list_returns_relevant_results
    # create will be new+save
    persona = Film.create(name: "Persona", director: "Ingmar Bergman", year: 1966, country: "Sweden", language: "Swedish", distributor: "MGM Home Entertainment", date: "12/17/13", format: "DVD", rating: 9, notes: "Loved it")
    the_third_generation = Film.create(name: "The Third Generation", director: 'Rainer Werner Fassbinder', year: 1975, country: "Germany", language: "German", distributor: "Unknown", date: "12/09/13", format: "DVD", rating: 7, notes: "Great political commentary, very absurdist")
    irma_vep = Film.create(name: "Irma Vep", director: 'Olivier Assayas', year: 1996, country: "France", language: "French, English", distributor: "Criterion Collection", date: "12/04/13", format: "DVD", rating: 8, notes: "Maggie Cheung is great as the lead")

    command = "./filmtracker list"
    expected = <<EOS.chomp
All Films:
Irma Vep: Olivier Assayas, 1996, France, French, English, Criterion Collection, 12/04/13, DVD, 8, Maggie Cheung is great as the lead, #{irma_vep.id}
Persona: Ingmar Bergman, 1966, Sweden, Swedish, MGM Home Entertainment, 12/17/13, DVD, 9, Loved it, #{persona.id}
The Third Generation: Rainer Werner Fassbinder, 1975, Germany, German, Unknown, 12/09/13, DVD, 7, Great political commentary, very absurdist, #{the_third_generation.id}
EOS
    assert_command_output expected, command
  end
end