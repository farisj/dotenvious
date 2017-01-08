require_relative 'dotenv_file'
require_relative 'yaml_file'

module Dotenvious
  module Loaders
    class Environments
      def initialize(options = {})
        @example_file = options[:example_file] || DEFAULT_EXAMPLE_ENV_FILE
      end

      def load_environments
        ENV.merge!(DotenvFile.load_from('.env'))
        example_env = if example_file.match(/\.ya?ml/)
          YamlFile.load_from(example_file)
        else
          DotenvFile.load_from(example_file)
        end
        ENV_EXAMPLE.merge!(example_env)
      end

      private

      attr_reader :example_file
    end
  end
end
