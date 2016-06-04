require_relative 'value_replacer'
require_relative 'mismatched_variable_finder'

module Dotenvious
  class Prompter
    def self.run
      keys_in_question.each do |key, status|
        case status
        when 'missing'
          decision = prompt_for_append(key)
          return if decision.downcase == 'q'
          env.write(env_entry(key) + "\n") if decision.downcase == 'y'
        when 'mismatched'
          # do mismatched stuff
          decision = prompt_for_replace(key)
          return if decision.downcase == 'q'
          ValueReplacer.new.replace(key) if decision.downcase == 'y'
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

    def self.prompt_for_append(var)
      puts env_entry(var)
      puts "Add to .env? [y/n/q]"
      STDIN.gets.strip
    end

    def self.prompt_for_replace(var)
      puts "ENV[#{var}] is set to: #{ENV[var]}"
      puts "Example [#{var}] is set to: #{ENV_EXAMPLE[var]}"
      puts "Replace with the example value? [y/n/q]"
      STDIN.gets.strip
    end

    def self.env_entry(var)
      "#{var}=#{ENV_EXAMPLE[var]}"
    end

    def self.env
      File.open('.env', 'a+')
    end
  end
end
