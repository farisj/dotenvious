require_relative 'dotenv_file'
require_relative 'yaml_file'

module Dotenvious
  module Loaders
    class Environments
      def initialize(options = {})
        @example_file = options[:example_file] || DEFAULT_EXAMPLE_ENV_FILE
        @env_file = options[:env_file] || DEFAULT_ENV_FILE
      end

      def load_environments
        ENV.merge!(DotenvFile.load_from(env_file))
        environment_loader = example_file.match(/\.ya?ml/) ? YamlFile : DotenvFile
        ENV_EXAMPLE.merge!(environment_loader.load_from(example_file))
      end

      private

      attr_reader :example_file, :env_file
    end
  end
end
