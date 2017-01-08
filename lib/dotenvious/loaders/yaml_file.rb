require 'yaml'

module Dotenvious
  module Loaders
    class YamlFile
      def self.load_from(filename)
        new(filename).load
      end

      def initialize(filename)
        @filename = filename
      end

      def load
        if file_missing?
          puts "This repo does not have an #{filename} file"
          return {}
        end
        Hash.new.tap do |environment|
          environment_variables.each do |(k, v)|
            environment[k] = v.to_s
          end
        end
      end

      private

      attr_reader :filename

      def file_missing?
        !File.exists?(filename)
      end

      def file
        YAML.load_file(filename)
      end

      def environment_variables
        begin
          file['machine']['environment']
        rescue NoMethodError => e
          puts "Error: #{filename} does not have a proper machine environment setup."
          puts "The program will now exit."
          exit
        end
      end
    end
  end
end
