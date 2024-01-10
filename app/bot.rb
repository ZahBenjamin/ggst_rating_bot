
require 'discordrb'
require 'dotenv'
require 'httparty'
Dotenv.load


# Start bot
bot = Discordrb::Commands::CommandBot.new token: ENV['BOT_TOKEN'], prefix:'!'
bot.run true


# commands go here

bot.command(:rating, description: 'Retrieves player MMR and deviation from ratingupdate.info API.') do |event, account_id, character_tag|

uri = URI('http://ratingupdate.info/api/player_rating/' + account_id + '/' + character_tag) 
response = HTTParty.get(uri)

  if response.success?
    data = JSON.parse(response.body)
    puts "API Data: #{data}"

    event.respond "MMR: #{data["value"].round} ± #{data["deviation"].round}"
  else
    puts "Error: #{response.code}"
    event.respond "Error: #{response.code}"
  end
end

bot.command(:help, description: 'Give list of commands and advice for ggst_rating_bot') do |event|
  event << 'Type !rating   <account_id>   <character_tag>  to get your MMR on ratingupdate!'
  event << 'Type !invite to get an invite code for the discord bot'
  event << 'Find account id and character by searching for your user on ratingupdate.info'
  event << 'After you find the right account_id and character code, try leaving a note on the bot profile on the right'
end


bot.command(:invite, description: 'Invite the bot to other servers') do |event|

  event.bot.invite_url
end


bot.join
