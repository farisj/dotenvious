require_relative 'example'
require 'dotenv'

module Dotenvious
  module Loaders
    class Env

      def initialize(filename)
        @filename = filename
      end

      def load_envs
        Dotenv.load
        Example.new(filename).load
      end

      private

      attr_reader :filename
    end
  end
end
