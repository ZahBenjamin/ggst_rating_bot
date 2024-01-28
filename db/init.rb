#!/usr/bin/env ruby

require 'pg'
require 'yaml'
require 'active_record'
require './app/models/ramlethals.rb'

# Establish Connection w/ Postgresql
begin
  db_config_file = File.open('config/database.yaml')
  db_config = YAML::load(db_config_file)
  puts db_config
  
  ActiveRecord::Base.establish_connection(db_config)
  puts "Connected to database!"
  Ramlethal.columns.each do |col|
    puts col.name
    puts col.type
  end
rescue PG::Error => e
  puts "Error connecting to database: #{e.message}"
ensure
  db_config_file.close if db_config_file
end