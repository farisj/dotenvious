module Dotenvious
  module Loaders
    class Environment
      def load
        return unless environment.keys.empty?
        #took from Dotenv source code whoops
        if file_missing?
          puts "This repo does not have an #{filename} file"
          return
        end
        file.each do |line|
          environment[$1] = $2 if line =~ /\A([\w_]+)=(.*)\z/
        end
      end

      private

      def file_missing?
        !File.exists?(filename)
      end

      def environment
        raise "environment must be defined in child class"
      end

      def filename
        raise "fileame must be defined in child class"
      end

      def file
        File.read(filename).split("\n")
      end
    end
  end
end
