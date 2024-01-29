# GGST Rating Bot

## Overview

This Discord bot retrieves player MMR (Matchmaking Rating) and deviation data from the ratingupdate.info API for Guilty Gear Strive. It offers the following commands:

    !rating      - Fetches player MMR and deviation from manual input of account id
    !set_account - Store ID so you don't have to manually input account id
    !mmr         - Fetches player MMR and deviation
    !profile     - Fetches player profile page, ratingupdate link
    !invite      - Generates an invite link to add the bot to other servers
    !help        - Provides a list of commands and usage instructions

## Commands

!rating

    Description: Retrieves player MMR and deviation from ratingupdate.info API with manual input.
    Usage: !rating <account_id> <character_tag>
    Example: !rating 12345678 RA


!set_account

    Description: Store player account id from ratingupdate.info .
    Usage: !set_account <account_id>
    Example: !set_account 12345678 

!mmr

    Description: Retrieves player MMR and deviation from ratingupdate.info API from stored account id.
    Usage: !mmr <character_tag>
    Example: !mmr RA

!profile

    Description: Retrieves player webpage from ratingupdate.info from stored account id.
    Usage: !profile 
    Example: !profile

!help

    Description: Displays a help message with available commands and instructions.
    Usage: !help

!invite

    Description: Generates an invite link for the bot.
    Usage: !invite

## Finding Account ID and Character Tag

    Visit ratingupdate.info and search for your username.
    Locate your account ID and character tag on your profile.
    Note them down for use with the !rating command.

## Using the Bot

    Add the bot to your Discord server.
    Use the !help command for a list of commands and instructions.
    Use the !invite command to share the bot with other servers.

## Additional Notes

    Consider leaving a note on the bot's profile with your account ID and character tag for easy access.

## Contributing

Feel free to contribute to the bot's development!

## License

GNU GENERAL PUBLIC LICENSE v. 3