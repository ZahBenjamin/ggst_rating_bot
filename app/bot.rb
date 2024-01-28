
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

# SET ACCOUNT - MVP DONE - CLEAN UP ADD TESTING 
bot.command(:set_account, description: 'First attempt at making db save work') do |event, account_id|
  server_id = event.server.id
  user_id   = event.user.id
  
  this_account = Ramlethal.find_by(guild: server_id, account: user_id)
  
  if account_id.nil?
    puts "Account id is nil"
    event << "Sorry buckaroo you need to put an account id or this won't work"
  elsif this_account.nil?
    user = Ramlethal.new do |u|
      u.guild = server_id
      u.account = user_id
      u.rating_update = account_id
    end
    user.save 
    
    event << "Sucessfully stored id"
    # puts "New account created, added to db, here is the new input #{this_account.rating_update}"
  else
    this_account.update(rating_update: account_id)
    puts "Here is the current account_id after update: #{this_account.rating_update}"
    event << "Account already exists, input updated"
  end
end    

# GET MMR AFTER ACCOUNT IS SET - MVP WORKING - NEEDS ERROR MESSAGE IF NO TAG PUT
bot.command(:mmr, description: 'GET MMR from calling DB') do |event, character_tag|
  server_id = event.server.id
  user_id   = event.user.id
  
  account_id = Ramlethal.find_by(guild: server_id, account: user_id).rating_update

  
  uri = URI('http://ratingupdate.info/api/player_rating/' + account_id + '/' + character_tag.upcase) 
  response = HTTParty.get(uri)

  if response.success?
    data = JSON.parse(response.body)
    puts "API Data: #{data}"
    puts "User Input: #{account_id}"
    event.respond "MMR: #{data["value"].round} ± #{data["deviation"].round}"
  else
    puts "Error: #{response.code}"
    event.respond "Error: #{response.code}"
    event.respond "Make sure you !set_account properly and put a valid character tag"
  end
end

bot.command(:match_up, description: 'Get matchup knowledge') do |event, character_tag, enemy_tag|
end


bot.command(:match_up_all, description: 'Send matchup knowledge for all characters') do |event, character_tag, enemy_tag|

end

bot.join
