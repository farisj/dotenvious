require_relative 'dotenv_file'

module Dotenvious
  module Loaders
    class Environments
      def load_envs
        ENV.merge!(DotenvFile.load_from('.env'))
        ENV_EXAMPLE.merge!(DotenvFile.load_from('.example-env'))
      end
    end
  end
end
