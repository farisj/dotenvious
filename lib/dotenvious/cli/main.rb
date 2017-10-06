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
        EnvFileConsolidator.new(file_options).run
        EnvFileSorter.new(options[:env_file]).run if options[:sort]
      end

      private

      attr_accessor :options
      attr_reader :file_options

      def file_options
        @file_options ||= Hash.new.tap do |hash|
          hash[:example_file] = options[:example_file] if options.key?(:example_file)
          hash[:env_file] = options[:env_file] if options.key?(:env_file)
        end
      end

      def parse_options
        parser = OptionParser.new do |opts|
          opts.banner = "How to use Dotenvious:"

          opts.on('-x .example-env-file', '--example .example-env-file', 'Specify which example file to use') do |file|
            options[:example_file] = file
          end

          opts.on('-f .env-file', '--file .env-file', 'Specify which file to write to') do |file|
            options[:env_file] = file
          end

          opts.on('-s', '--sort', 'Sort env file by key names alphabetically') do
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
