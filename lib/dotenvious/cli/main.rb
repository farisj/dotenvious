require_relative '../loaders/environments'
require_relative '../missing_variable_finder'
require_relative '../prompter'
require_relative '../loaders/configuration'
require 'pry'
module Dotenvious
  module CLI
    class Main
      def run
        if ARGV[0].to_s.empty?
          Loaders::Configuration.new.load
          Loaders::Environments.new.load_envs
          unless all_vars_present? && all_vars_match?
            alert_user
            decision = STDIN.gets.strip
            Prompter.run if decision.downcase == 'y'
          end
        else
          ask_user_to_remove_flags
        end
      end

      private

      def alert_user
        puts "You have missing ENV variables. Examime them? [y/n]"
      end

      def ask_user_to_remove_flags
        puts "dotenvious does not have flags at this time. Run 'dotenvious' without flags to get the main functionality."
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
