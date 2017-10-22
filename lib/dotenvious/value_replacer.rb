module Dotenvious
  class ValueReplacer
    def initialize(filename)
      @filename = filename
    end

    def replace(key)
      line_number = base_env.find_index do |line|
        line.match(/^#{key}=/)
      end
      updated_env = base_env.dup
      updated_env[line_number] = "#{key}=#{ENV_EXAMPLE[key]}"
      env_writer.write(updated_env.join("\n") + "\n")
    end

    private

    attr_reader :base_env, :filename

    def base_env
      @base_env ||= File.read(filename).split("\n")
    end

    def env_writer
      File.open(filename, 'w')
    end
  end
end
