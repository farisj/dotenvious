# Dotenvious

A gem to manage .env dependencies.

Your `.env` file gets jealous when `.example-env` has keys that it does not. Dotenvious helps `.env` get back on the right track.

This gem exists to solve the following workflow:

Imagine you're working at a small to mid-size team in a startup whose architecture is constantly evolving. In a fast-moving startup, environment variable may change rapidly.

If you're working on one team within a larger application, environment variables may be added to your codebase that you might know were added, some of which may break the application's code after pulling from your updated repository.

Dotenvious solves this problem. See that your most recent pull breaks Rails on startup? Run dotenvious and it will present to you the new variables that were added - and give you the option to immediately add them to your `.env` file.

Dotenvious eliminates the pain of manually parsing through a newly changed `.example-env` file to see which new breaking variables have been added. 

## Getting Started

???

## What You Need

This gem compares the variables set in your `.env` file with what exists in `.example-env`. The gem includes a CLI which walks you through the variables missing in `.env` but present in `.example-env`.

Currently, this gem relies on [Dotenv](https://github.com/bkeepers/dotenv) to load dependencies from ENV.

## Future Work

[ ] Figure out how to incorporate in rakefile

[ ] Compare keys already present in both files but with different values

[ ] Ability to choose which development `.env-*` file to load from

[ ] Perist user's individual choices in a `.dotenvious` file in directory

[ ] Option to always run on boot after pull from master

[ ] More things are always on the horizon! 
