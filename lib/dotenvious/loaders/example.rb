require_relative 'environment'

module Dotenvious
  module Loaders
    class Example < Environment
      private

      def environment
        Dotenvious::ENV_EXAMPLE
      end
    end
  end
end
