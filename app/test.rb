
# essentially psueodcode below

bot.message(content: /!store (.+)/) do |event|
  input = event.message.content.match(/!store (.+)/)[1]
  user_id = event.user.id
  channel_id = event.channel.id

  # Store input in the database, associating it with user_id and channel_id
  # (Database interaction code will depend on your chosen database)
end

bot.command(:retrieve) do |event|
  # Retrieve data from the database based on user_id or channel_id
  # (Database interaction code will depend on your chosen database)
  retrieved_data = # ...
  event.respond "Retrieved data: #{retrieved_data}"
end

# steps:

# add postgres db on machine and in gemfile/repo

# DB to store input data(rating updating acconut id), userIDS(from discord channel), channelIDS(Discord Channel)
## choose suitable DB model(ask phillip)

# Implement DB interactions
## code to connect DB to adapter gem pg
## Implement methods for storing and retrieving data from the database, ensuring proper handling of user IDs and channel IDs.


# Testing & Deployment
## Pry
## Testing
## GH Actions?

### CONSIDERATIONS: Error Handling, Security, Data Management