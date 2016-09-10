require_relative 'example'
require_relative 'env'

module Dotenvious
  module Loaders
    class Environments

      def initialize(filename)
        @filename = filename
      end

      def load_envs
        Env.new('.env').load
        Example.new(filename).load
      end

      private

      attr_reader :filename
    end
  end
end
