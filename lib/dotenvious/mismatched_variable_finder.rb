module Dotenvious
  class MismatchedVariableFinder
    def self.mismatched_vars?
      mismatched_vars.any?
    end

    def self.mismatched_vars
      keys.select do |key|
        ENV_EXAMPLE.has_key?(key) && ENV_EXAMPLE[key] != ENV[key]
      end
    end

    private

    def self.keys
      return ENV.keys if CONFIG[:ignored_vars].nil?
      ENV.keys.reject do |key|
        CONFIG[:ignored_vars].include?(key)
      end
    end
  end
end
