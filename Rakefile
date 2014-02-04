#!/usr/bin/env ruby
# -*- ruby -*-

require_relative 'lib/environment'
require 'rake/testtask'
Rake::TestTask.new() do |t|
  t.pattern = "test/test_*.rb"
end

desc "Run tests"
task :default => :test

desc 'import data from the given file'
task :import_data do
  Environment.environment = "production"
  require_relative 'lib/importer'
  Importer.import("data/FilmTracker.csv")
end

desc "Create the production database setup"
task :bootstrap_database do
	Environment.environment = "production"
	database = Environment.database_connection
	create_tables(database)
end


desc "prepare the test database"
task :test_prepare do
	File.delete("db/filmtracker_test.sqlite3")
	Environment.environment = "test"
	database = Environment.database_connection
	create_tables(database)
end

def create_tables(database_connection)
	database_connection.execute("CREATE TABLE films (id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(50), director varchar (50), year integer, country varchar(30), language varchar(20), distributor varchar(30), date varchar(10), rating integer, format varchar(15), notes varchar(300))")
end
