module Dotenvious
  class FileNotFoundError < ArgumentError
    attr_reader :file
    def initialize(filename)
      @file = filename
      super
    end
  end
end
