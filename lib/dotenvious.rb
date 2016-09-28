module Dotenvious
  DEFAULT_ENV_FILE = '.env'
  DEFAULT_EXAMPLE_ENV_FILE = '.example-env'
  ENV = {}
  ENV_EXAMPLE = {}
  CONFIG = {}
end

require_relative 'dotenvious/cli/main'
