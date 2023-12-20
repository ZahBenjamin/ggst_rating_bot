# frozen_string_literal: true

require 'discordrb'
require 'dotenv'
# require 'net/http'
require 'httparty'
Dotenv.load




bot = Discordrb::Commands::CommandBot.new token: ENV['BOT_TOKEN'], prefix:'!'
bot.run true

# commands go here

bot.command :get_request do |event|

uri = URI('http://ratingupdate.info/api/player_rating/2EC3EA2818411DB/TE') 
response = HTTParty.get(uri)

  if response.success?
    data = JSON.parse(response.body)
    puts "API Data: #{data}"

    event.respond "MMR: #{data["value"]}, DEVIATION: #{data["deviation"]}"
  else
    puts "Error: #{response.code}"
    event.respond "Error: #{response.code}"
  end
end



bot.command(:invite, chain_usable: false) do |event|
  # This simply sends the bot's invite URL, without any specific permissions,
  # to the channel.
  event.bot.invite_url
end


bot.join
