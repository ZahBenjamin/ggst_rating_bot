
require 'discordrb'
require 'dotenv'
require 'httparty'
require './db/init.rb'
Dotenv.load


# Start bot
bot = Discordrb::Commands::CommandBot.new token: ENV['BOT_TOKEN'], prefix:'!'
bot.run true

# Baseline GET RATING, manually input account ID 
bot.command(:rating, description: 'Retrieves player MMR and deviation from ratingupdate.info API.') do |event, account_id, character_tag|

uri = URI('http://ratingupdate.info/api/player_rating/' + account_id + '/' + character_tag) 
response = HTTParty.get(uri)

  if response.success?
    data = JSON.parse(response.body)
    puts "API Data: #{data}"
    puts "User Input: #{account_id}"
    event.respond "MMR: #{data["value"].round} ± #{data["deviation"].round}"
  else
    puts "Error: #{response.code}"
    event.respond "Error: #{response.code}"
  end
end

# HELP Command to describe how to use bot
bot.command(:help, description: 'Give list of commands and advice for ggst_rating_bot') do |event|
  event << 'Type !rating   <account_id>   <character_tag>  to get your MMR on ratingupdate!'
  event << 'Type !invite to get an invite code for the discord bot'
  event << 'Find account id and character by searching for your user on ratingupdate.info'
  event << 'After you find the right account_id and character code, try leaving a note on the bot profile on the right'
  puts "Here is server id and name: #{event.server.name} AKA #{event.server.id}"
  puts "Here is user name and id: #{event.user.name} AKA #{event.user.id}"
end

# INVITE Command 
bot.command(:invite, description: 'Invite the bot to other servers') do |event|

  event.bot.invite_url
end


bot.command(:test, description: 'First attempt at making db save work') do |event, account_id|
  server_id = event.server.id
  user_id   = event.user.id
  
  this_account = Ramlethal.find_by(guild: server_id, account: user_id)
  
  if this_account.nil?
    user = Ramlethal.new do |u|
      u.guild = server_id
      u.account = user_id
      u.rating_update = account_id
    end
    user.save 
    
    puts "THIS IS THE IF"
    event << "Account created, this is where id goes to show it was made"
  elsif account_id.nil?
    puts "Account id is nil"
    event << "Sorry buckaroo you need to put an account id or this won't work"
  else
    puts "THIS IS THE ELSE"
    event << "Account already exists, input updated"
    this_account.update(rating_update: account_id)
    puts "Here is the current account_id: #{Ramlethal.find_by(guild: server_id).rating_update}"
  end
end    


bot.command(:calvados, description: 'GET MMR from calling DB') do |event, character_tag|
  server_id = event.server.id
  user_id   = event.user.id
  
  account_id = Ramlethal.find_by(guild: server_id, account: user_id).rating_update
  
  uri = URI('http://ratingupdate.info/api/player_rating/' + account_id + '/' + character_tag) 
  response = HTTParty.get(uri)
  
  if response.success?
    data = JSON.parse(response.body)
    puts "API Data: #{data}"
    puts "User Input: #{account_id}"
    event.respond "MMR: #{data["value"].round} ± #{data["deviation"].round}"
  else
    puts "Error: #{response.code}"
    event.respond "Error: #{response.code}"
  end
end

# notes
# puts "Here is a call to the DB #{Ramlethal.find(1).mmr}"
# puts "Here is a call to the DB #{Ramlethal.find_by(id: 1).mmr}"   RETURNS FOO
# puts "Here is a call to the DB #{Ramlethal.find(1).mmr}"          THIS ALSO RETURNS FOO

# puts "Here is the RATING UPDATE ACCOUNT ID: #{account_id}"
# puts "Here is the GUILD ID: #{event.server.id}"
# puts "Here is the DISCORD ACCOUNT ID: #{event.user.id}"
# puts "Here is first user#{Ramlethal.find_by(id: 1)} "

bot.join
