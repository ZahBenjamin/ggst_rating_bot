#!/usr/bin/env ruby

require 'pg'
require 'yaml'
require 'active_record'

class Ramlethal < ActiveRecord::Base
end

# Establish Connection w/ Postgresql
begin
  db_config_file = File.open('config/database.yaml')
  db_config = YAML::load(db_config_file)
  puts db_config

  ActiveRecord::Base.establish_connection(db_config)
  puts "Connected to database!"
  # THE RESULTS DID NOT RETURN EXPECTED
  # result = Ramlethal.connection.execute("SELECT * FROM  ramlethals;")
  # result = Ramlethal.find_by_sql("SELECT * FROM  ramlethals;")
  # puts "Result here #{result}"
rescue PG::Error => e
  puts "Error connecting to database: #{e.message}"
ensure
  db_config_file.close if db_config_file
end


# THIS WORKED
# user = Ramlethal.new do |u|
#   u.guild = 1
#   u.account = 1
#   u.mmr = "foo"
#   u.mmr_deviation = "bar"
# end
# user.save

# Input.create(guild: 1, account: 1, rating_update: 'placeholder', mmr: 'foo', mmr_deviation: 'bar')


# SAMPLE TABLE
# CREATE TABLE ramlethals (
#   id serial PRIMARY KEY,
#   guild bigint NOT NULL,
#   account int NOT NULL,
#   rating_update text,
#   mmr smallint REAL,
#   mmr_deviation smallint REAL
# );

# useful commpands postgres
# - psql postgres
# - CREATE DB 
# - CREATE TABLE 
# - \dt 
# - SELECT * FROM table;
# - \l 



#    EXAMPLE BELOW 
#   conn = PG.connect( dbname: 'sales' )
#   conn.exec( "SELECT * FROM pg_stat_activity" ) do |result|
#     puts "     PID | User             | Query"
#     result.each do |row|
#       puts " %7d | %-16s | %s " %
#         row.values_at('pid', 'usename', 'query')
#     end
#   end