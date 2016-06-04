module Dotenvious
  class MismatchedVariableFinder
    def self.mismatched_vars?
      mismatched_vars.any?
    end

    def self.mismatched_vars
      ENV.keys.select do |key|
        ENV_EXAMPLE.has_key?(key) && ENV_EXAMPLE[key] != ENV[key]
      end
    end
  end
end
