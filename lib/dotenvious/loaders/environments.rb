require_relative 'example'
require_relative 'env'

module Dotenvious
  module Loaders
    class Environments
      def load_envs
        Env.new.load
        Example.new.load
      end
    end
  end
end
