module Dotenvious
  module CLI
    class EnvFileSorter
      def initialize(filename = DEFAULT_ENV_FILE)
        @filename = filename
      end

      def run
        File.open(filename, 'w') do |file|
          file.write(sorted_env_text)
        end
        puts "Your #{filename} file is now neat and orderly. Enjoy!"
      end

      private

      attr_reader :filename

      def sorted_env_text
        ENV.sort.map do |(key, value)|
          "#{key}=#{value}"
        end.join("\n")
      end
    end
  end
end
