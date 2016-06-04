require_relative 'value_replacer'
require_relative 'mismatched_variable_finder'
require_relative 'prompter'

module Dotenvious
  class Prompter
    def self.run
      keys_in_question.each do |key, status|
        decision = prompt(key, status)
        return if decision == 'q'
        next unless decision.downcase == 'y'

        if status == 'missing'
          env.write(env_entry(key) + "\n")
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
      ENV_EXAMPLE.keys - ENV.keys
    end

    def self.mismatched_vars
      MismatchedVariableFinder.mismatched_vars
    end

    def self.prompt(var, status)
      if status == 'missing'
        display_missing_output(var)
      elsif status == 'mismatched'
        display_mismatch_output(var)
      end
      STDIN.gets.strip
    end

    def self.display_missing_output(var)
      puts env_entry(var)
      puts "Add to .env? [y/n/q]"
    end

    def self.display_mismatch_output(var)
      puts "ENV[#{var}] is set to: #{ENV[var]}"
      puts "Example [#{var}] is set to: #{ENV_EXAMPLE[var]}"
      puts "Replace with the example value? [y/n/q]"
    end

    def self.env_entry(var)
      "#{var}=#{ENV_EXAMPLE[var]}"
    end

    def self.env
      File.open('.env', 'a+')
    end
  end
end
