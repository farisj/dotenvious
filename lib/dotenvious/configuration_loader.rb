require 'pry'
require_relative 'configuration'
module Dotenvious
  class ConfigurationLoader
    def load
      load_config if config_file_present?
    end

    private

    attr_reader :file

    def load_config
      Kernel.load dotenvious
    end

    def dotenvious
      Dir.pwd + '/.envious'
    end

    def config_file_present?
      File.file?(dotenvious)
    end
  end
end
