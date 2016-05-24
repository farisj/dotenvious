module Dotenvious
  class MissingVariableFinder
    def self.all_vars_present?
      Dotenvious::ENV_EXAMPLE.keys.all? do |key|
        ENV.has_key?(key)
      end
    end
  end
end