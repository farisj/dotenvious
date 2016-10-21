require_relative 'environment'

module Dotenvious
  module Loaders
    class Example < Environment
      private

      def filename
        DEFAULT_EXAMPLE_ENV_FILE
      end

      def environment
        Dotenvious::ENV_EXAMPLE
      end
    end
  end
end
