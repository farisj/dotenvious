require_relative 'loader'
require_relative 'missing_variable_finder'
require 'pry'
module Dotenvious
  class CLI
    def initialize
      #figure out which file - for now can just look .env.example or .example-env
      @filename = '.example-env' # or .env-example
    end

    def run
      Loader.new(filename).load_envs
      # binding.pry
      abort unless all_vars_present?
    end

    def all_vars_present?
      MissingVariableFinder.all_vars_present?
    end

    private

    attr_reader :filename

    def abort
      abort_message = 'Hold up! Your .env file is green with envy towards .example-env. You should update it.'
      super abort_message
    end
  end
end