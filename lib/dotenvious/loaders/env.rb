module Dotenvious
  module Loaders
    class Env
      def initialize(filename)
        @filename = filename
      end

      def load
        #took from Dotenv source code whoops
        file.each do |line|
          Dotenvious::ENV[$1] = $2 if line =~ /\A([\w_]+)=(.*)\z/
        end
      end

      private

      def file
        File.read(@filename).split("\n")
      end

      attr_reader :filename
    end
  end
end
