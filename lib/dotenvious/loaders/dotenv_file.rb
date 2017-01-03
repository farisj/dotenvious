module Dotenvious
  module Loaders
    class DotenvFile
      def self.load_from(filename)
        new(filename).load
      end

      def initialize(filename)
        @filename = filename
      end

      def load
        # return unless environment.keys.empty?
        #took from Dotenv source code whoops
        if file_missing?
          puts "This repo does not have an #{filename} file"
          return
        end
        Hash.new.tap do |environment|
          file.each do |line|
            environment[$1] = $2 if line =~ /\A([\w_]+)=(.*)\z/
          end
        end
      end

      private

      attr_reader :filename

      def file_missing?
        !File.exists?(filename)
      end

      def file
        File.read(filename).split("\n")
      end
    end
  end
end
