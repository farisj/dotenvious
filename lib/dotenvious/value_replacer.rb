module Dotenvious
  class ValueReplacer
    def replace(key)
      line_number = base_env.find_index do |line|
        line.match(/^#{key}=/)
      end
      updated_env = base_env.dup
      updated_env[line_number] = "#{key}=#{ENV_EXAMPLE[key]}"
      env_writer.write(updated_env.join("\n"))
    end

    private

    attr_reader :base_env

    def base_env
      @base_env ||= File.read('.env').split("\n")
    end

    def env_writer
      File.open('.env', 'w')
    end
  end
end
