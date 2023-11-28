# frozen_string_literal: true

require 'discordrb'
require 'config/secrets.yml'

@my_bot = Discordrb::Bot.new token: @bot_token, client_id: @client_id
@my_bot.run true

# commands go here

@my_bot.join
