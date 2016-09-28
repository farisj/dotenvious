require_relative '../loaders/environments'
require_relative '../missing_variable_finder'
require_relative '../prompter'
require_relative '../loaders/configuration'
require 'pry'
module Dotenvious
  module CLI
    class Main
      def initialize
        #figure out which file - for now can just look .env.example or .example-env
        @filename = '.example-env' # or .env-example
      end

      def run
        Loaders::Configuration.new.load
        Loaders::Environments.new(filename).load_envs
        unless all_vars_present? && all_vars_match?
          alert_user
          decision = STDIN.gets.strip
          Prompter.run if decision.downcase == 'y'
        end
      end

      private

      attr_reader :filename

      def alert_user
        puts "You have missing ENV variables. Examime them? [y/n]"
      end

      def all_vars_present?
        !MissingVariableFinder.required_vars_missing?
      end

      def all_vars_match?
        !MismatchedVariableFinder.mismatched_vars?
      end

      def abort
        abort_message = 'Hold up! Your .env file is green with envy towards .example-env. You should update it.'
        super abort_message
      end
    end
  end
end
