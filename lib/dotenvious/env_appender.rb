module Dotenvious
  class EnvAppender
    def initialize(filename)
      @filename = filename
    end

    def append(key)
      env.write("#{key}=#{ENV_EXAMPLE[key]}\n")
    end

    private

    attr_reader :env, :filename

    def env
      @env ||= File.open(filename, 'a+')
    end
  end
end
