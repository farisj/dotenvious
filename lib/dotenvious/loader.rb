require_relative 'example_loader'
require 'dotenv'

module Dotenvious
  class Loader

    def initialize(filename)
      @filename = filename
    end

    def load_envs
      Dotenv.load
      ExampleLoader.new(filename).load
    end

    private

    attr_reader :filename
  end
end