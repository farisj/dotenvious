module Dotenvious
  class EnvAppender
    def self.run
      missing_vars.each do |var|
        decision = prompt_for_append(var)
        return if decision.downcase == 'q'
        env.write(env_entry(var) + "\n") if decision.downcase == 'y'
      end
    end

    private

    def self.missing_vars
      ENV_EXAMPLE.keys - ENV.keys
    end

    def self.prompt_for_append(var)
      puts env_entry(var)
      puts "Add to .env? [y/n/q]"
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