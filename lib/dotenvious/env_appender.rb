module Dotenvious
  class EnvAppender
    def append(key)
      env.write("#{key}=#{ENV_EXAMPLE[key]}\n")
    end

    private

    attr_reader :env

    def env
      @env ||= File.open('.env', 'a+')
    end
  end
end
