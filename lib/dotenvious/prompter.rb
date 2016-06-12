require_relative 'value_replacer'
require_relative 'mismatched_variable_finder'
require_relative 'prompter'
require_relative 'env_appender'

module Dotenvious
  class Prompter
    def self.run
      keys_in_question.each do |key, status|
        decision = prompt(key, status)
        return if decision == 'q'
        next unless decision.downcase == 'y'

        if status == 'missing'
          EnvAppender.new.append(key)
        elsif status == 'mismatched'
          ValueReplacer.new.replace(key)
        end
      end
    end

    private

    def self.keys_in_question
      missing_keys = missing_vars.zip(['missing'] * missing_vars.length)
      mismatched_keys = mismatched_vars.zip(['mismatched'] * mismatched_vars.length)
      missing_keys + mismatched_keys
    end

    def self.missing_vars
      MissingVariableFinder.missing_required_vars
    end

    def self.mismatched_vars
      MismatchedVariableFinder.mismatched_vars
    end

    def self.prompt(var, status)
      send(:"display_#{status}_output", var)
      STDIN.gets.strip
    end

    def self.display_missing_output(var)
      puts "#{var}=#{ENV_EXAMPLE[var]}"
      puts "Add to .env? [y/n/q]"
    end

    def self.display_mismatched_output(var)
      puts "ENV[#{var}] is set to: #{ENV[var]}"
      puts "Example [#{var}] is set to: #{ENV_EXAMPLE[var]}"
      puts "Replace with the example value? [y/n/q]"
    end
  end
end
