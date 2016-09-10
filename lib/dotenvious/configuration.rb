require 'pry'
module Dotenvious
  class Configuration

    class ConfigurationError < StandardError; end

    def initialize
      yield self if block_given?
    end

    def example_file=(filename)
      raise ConfigurationError if not_string?(filename)
      CONFIG[:example_file] = filename
    end

    def custom_variables=(vars)
      raise ConfigurationError unless all_caps_array?(vars)
      CONFIG[:custom_variables] = vars
    end

    def optional_vars=(vars)
      raise ConfigurationError unless all_caps_array?(vars)
      CONFIG[:optional_vars] = vars
    end

    private

    def not_string?(filename)
      filename.class != String
    end

    def all_caps_array?(vars)
      vars.class == Array &&
      vars.all? do |var|
        var.class == String && var.upcase == var
      end
    end
  end
end
