#!/usr/bin/env ruby
# -*- ruby -*-

require 'rake/testtask'
Rake::TestTask.new() do |t|
  t.pattern = "test/test_*.rb"
end

desc "Run tests"
task :default => :test

desc "Prepares the database"
task :bootstrap_database do
  require 'sqlite3'
  database = SQLite3::Database.new("db/filmtracker_test.sqlite3")
  database.execute("CREATE TABLE films (id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(50), director varchar(50), year integer, country varchar(30))")
end