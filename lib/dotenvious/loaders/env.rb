module Dotenvious
  module Loaders
    class Env < Environment
      private

      def environment
        Dotenvious::ENV
      end
    end
  end
end
