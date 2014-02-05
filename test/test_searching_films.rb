require_relative 'helper'

class TestSearchingFilms < FilmTest
  def test_search_returns_relevant_results
    persona = Film.create(name: "Persona", director: "Ingmar Bergman", year: 1966, country: "Sweden", language: "Swedish", distributor: "MGM Home Entertainment", date: "12/17/13", format: "DVD", rating: 9, notes: "Loved it")
    the_third_generation = Film.create(name: "The Third Generation", director: 'Rainer Werner Fassbinder', year: 1975, country: "Germany", language: "German", distributor: "Unknown", date: "12/09/13", format: "DVD", rating: 7, notes: "Great political commentary, very absurdist")
    irma_vep = Film.create(name: "Irma Vep", director: 'Olivier Assayas', year: 1996, country: "France", language: "French, English", distributor: "Criterion Collection", date: "12/04/13", format: "DVD", rating: 8, notes: "Maggie Cheung is great as the lead")

    shell_output = ""
    IO.popen('./filmtracker search --environment test', 'r+') do |pipe|
      pipe.puts("Third")
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "The Third Generation"
    assert_not_in_output shell_output, "Irma Vep", "Persona"
  end
end