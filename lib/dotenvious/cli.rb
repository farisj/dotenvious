require_relative 'loader'
require_relative 'missing_variable_finder'
require_relative 'env_appender'

module Dotenvious
  class CLI
    def initialize
      #figure out which file - for now can just look .env.example or .example-env
      @filename = '.example-env' # or .env-example
    end

    def run
      Loader.new(filename).load_envs
      unless all_vars_present?
        alert_user
        decision = STDIN.gets.strip
        EnvAppender.run if decision.downcase == 'y'
      end
    end

    private

    attr_reader :filename

    def alert_user
      puts "You have missing ENV variables. Examime them? [y/n]"
    end

    def all_vars_present?
      MissingVariableFinder.all_vars_present?
    end

    def abort
      abort_message = 'Hold up! Your .env file is green with envy towards .example-env. You should update it.'
      super abort_message
    end
  end
end