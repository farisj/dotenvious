require_relative 'dotenv_file'

module Dotenvious
  module Loaders
    class Environments
      def initialize(options = {})
        @example_file = options[:example_file] || DEFAULT_EXAMPLE_ENV_FILE
      end

      def load_environments
        ENV.merge!(DotenvFile.load_from('.env'))
        ENV_EXAMPLE.merge!(DotenvFile.load_from(example_file))
      end

      private

      attr_reader :example_file
    end
  end
end
