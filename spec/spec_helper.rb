require 'bundler/setup'
Bundler.setup

require 'dotenvious' # and any other gems you need

RSpec.configure do |config|
  #copied & pasted from http://stackoverflow.com/questions/15430551
  #whoops
  original_stderr = $stderr
  original_stdout = $stdout
  config.before(:all) do
    # Redirect stderr and stdout
    $stderr = File.open(File::NULL, "w")
    $stdout = File.open(File::NULL, "w")
  end
  config.after(:all) do
    $stderr = original_stderr
    $stdout = original_stdout
  end
end
