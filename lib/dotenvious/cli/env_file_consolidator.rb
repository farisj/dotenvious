require_relative '../loaders/environments'
require_relative '../missing_variable_finder'
require_relative '../prompter'
require_relative '../loaders/configuration'

module Dotenvious
  module CLI
    class EnvFileConsolidator
      def initialize(example_file: DEFAULT_EXAMPLE_ENV_FILE, env_file: DEFAULT_ENV_FILE)
        @example_file = example_file
        @env_file = env_file
      end

      def run
        Loaders::Configuration.new.load
        Loaders::Environments.new({example_file: example_file, env_file: env_file}).load_environments
        unless all_vars_present? && all_vars_match?
          alert_user
          decision = STDIN.gets.strip
          Prompter.new(env_file).run if decision.downcase == 'y'
        end
      end

      private

      attr_reader :example_file, :env_file, :filename

      def alert_user
        puts "You have missing ENV variables. Examime them? [y/n]"
      end

      def all_vars_present?
        !MissingVariableFinder.required_vars_missing?
      end

      def all_vars_match?
        !MismatchedVariableFinder.mismatched_vars?
      end
    end
  end
end
