
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

bot.command(:set_account, description: 'Set rating_update account id to discord account') do |event, account_id|
  puts "Here is the RATING UPDATE ACCOUNT ID: #{account_id}"
  puts "Here is the GUILD ID: #{event.server.id}"
  puts "Here is the DISCORD ACCOUNT ID: #{event.user.id}"
  puts "Here is the hello world"
  event << 'Successfully saved rating_update ID to bot!'
  # 1. take inputs and put in the DB table
  # 2. Make sure that when stored in DB it does not create duplicates, just overwrites old input for account_id
end


bot.join