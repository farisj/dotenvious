require 'optparse'
require_relative 'env_file_consolidator'
require_relative 'env_file_sorter'

module Dotenvious
  module CLI
    class Main
      def initialize
        @options = {}
      end

      def run
        parse_options
        EnvFileConsolidator.new({example_file: options[:file]}).run
        EnvFileSorter.new.run if options[:sort]
      end

      private

      attr_accessor :options

      def parse_options
        parser = OptionParser.new do |opts|
          opts.banner = "How to use Dotenvious:"

          opts.on('-f .example-environment-file', '--file .example-environment-file', 'Specify which example file to use') do |file|
            options[:file] = file
          end

          opts.on('-s', '--sort', 'Sort .env file by key names alphabetically') do
            options[:sort] = true
          end

          opts.on('-h', '--help', 'View this message') do
            puts opts
            exit
          end
        end

        begin
          parser.parse!
        rescue OptionParser::InvalidOption => e
          puts "Warning #{e}"
        end
      end
    end
  end
end
