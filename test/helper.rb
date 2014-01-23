require 'minitest/autorun'


class FilmTest < MiniTest::Unit::TestCase
  def database
    # memoization
    @database ||= SQLite3::Database.new("db/filmtracker_test.sqlite3")
  end

  def teardown
    database.execute("delete from films")
  end

  def assert_command_output expected, command
    actual = `#{command}`.strip
    assert_equal expected, actual
  end
end