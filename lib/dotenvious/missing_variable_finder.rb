module Dotenvious
  class MissingVariableFinder
    def self.required_vars_missing?
      missing_required_vars.any?
    end

    def self.missing_required_vars
      keys.reject do |key|
        ENV.has_key?(key)
      end
    end

    private

    def self.keys
      all_keys = Dotenvious::ENV_EXAMPLE.keys
      return all_keys if CONFIG[:optional_variables].nil?
      all_keys.reject do |key|
        CONFIG[:optional_variables].include?(key)
      end
    end
  end
end
