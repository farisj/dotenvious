module Dotenvious
  module Loaders
    class Env < Environment
      private

      def filename
        DEFAULT_ENV_FILE
      end

      def environment
        Dotenvious::ENV
      end
    end
  end
end
