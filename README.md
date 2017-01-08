# Dotenvious

A gem to manage `.env` dependencies.

Your `.env` file gets jealous when `.example-env` has keys that it does not. Dotenvious helps `.env` get back on the right track.

See that your most recent pull breaks Rails on startup due to missing environment variables? Run `bundle exec dotenvious` and it will present to you the new variables that were added - and give you the option to immediately add them to your `.env` file.

Dotenvious eliminates the pain of manually parsing through a newly changed `.example-env` file to see which new breaking variables have been added.

## Getting Started

Add the gem to your Gemfile by the following:

```
 group :development do
	gem 'dotenvious'
end

```

then run:

```
bundle install
bundle exec dotenvious
```

The CLI will then take you through your `.env` and `.example-env` files, prompting you to add missing variables or overwrite differing variables.


## Customization

Currently, one can whitelist which variables they want to exclude from examination.

First, add a `.envious` file to the root of your project. In the file, you can specify which variables to ignore fully (`optional_variables`) or those that you need but are expected to have different values from those provided in `.example-env` (`custom_variables`).

```
Dotenvious::Configuration.new do |config|

	config.custom_variables = %w(VARIABLES WITH DIFFERENT VALUES)

	config.optional_variables = %w(VARIABLES YOU DONT NEED)

end

```

These both need to be arrays.

`dotenvious` will ignore the variables specified.

### Additional Options

#### --sort

Running `dotenvious --sort` will sort your `.env` file alphabetically.

#### --file

To select another example enironment file to use, add the optional flag `--file .env-example` or whatever your filename is.

This gem also works with `.yml` or `.yaml` files designed for CircleCI. To use a `.yaml` file of this style, it must have the format:

```
machine:
	environment:
		MY_ENV_VAR_1: "asdfghjk"
		MY_ENV_VAR_2: "qwertyu"
		...
```

Other configuration formats can be added in the future.

## Future Work

- [ ] Persist user's individual choices in a `.envious` file in directory after run

- [ ] Auto create `.envious` with user specified options if not exists

- [ ] Remove duplicate variables if declared twice in `.env` file
