require_relative 'example'
require_relative 'env'

module Dotenvious
  module Loaders
    class Environments
      def load_envs
        begin
          Env.new.load
        rescue Dotenvious::FileNotFoundError => ex
          STDERR.puts "#{ex.file} not found"
        end
        begin
          Example.new.load
        rescue Dotenvious::FileNotFoundError => ex
          STDERR.puts "#{ex.file} not found"
        end
      end
    end
  end
end
