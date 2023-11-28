# frozen_string_literal: true

require 'discordrb'

bot.command :long do |event|
  event << 'This is a long message'
  event << 'It has multiple lines that are each send by doing `event << line`.'
  event << 'This is an easy way to do such long messages, or to create lines that should only be sent conditionally'