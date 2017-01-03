require_relative '../loaders/env'

module Dotenvious
  module CLI
    class EnvFileSorter
      def run
        File.open('.env', 'w') do |file|
          file.write(sorted_env_text)
        end
        puts 'Your .env file is now neat and orderly. Enjoy!'
      end

      private

      def sorted_env_text
        ENV.sort.map do |(key, value)|
          "#{key}=#{value}"
        end.join("\n")
      end
    end
  end
end
