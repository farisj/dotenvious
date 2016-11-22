module Dotenvious
  module CLI
    class EnviousFileConfiguror
      def run
        unless envious_present?
          puts "You don't have an .envious file present. Create one now? [y\\n]"
          decision = STDIN.gets.strip.downcase
          if decision == 'y'
            create_blank_envious_file
          end
        end
      end

      private

      def create_blank_envious_file
        File.open('.envious', 'w') do |file|
          file.write(configuration_skeletion)
        end
      end

      def configuration_skeletion
        <<~CONFIG
          ### Generated by dotenvious. Edit with care!
          Dotenvious::Configuration.new do |config|
            config.custom_variables = []
            config.optional_variables = []
          end
        CONFIG
      end

      def envious_present?
        File.exist?('.envious')
      end
    end
  end
end
