require_relative 'helper'

class TestSearchingFilmss < FilmTest
  def test_search_returns_relevant_results
    `./filmtracker add Persona --director "Ingmar Bergman" --year 1966 --country Sweden --environment test`
    `./filmtracker add "The Third Generation" --director "Rainer Werner Fassbinder" --year 1975 --country Germany --environment test`
    `./filmtracker add "Irma Vep" --director "Olivier Assayas" --year 1996 --country France --environment test`

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