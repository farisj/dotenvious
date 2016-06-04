require 'spec_helper'

describe Dotenvious::EnvAppender do
  describe '#append' do
    before do
      stub_const('Dotenvious::ENV', { 'test' => 'example' } )
      stub_const('Dotenvious::ENV_EXAMPLE', { 'test' => 'example', 'test2' => 'example2' } )
    end
    it 'appends the value to the end of the .env file' do
      env_double = double('File', write: nil)
      expect(env_double).to receive(:write).with("test2=example2\n")
      expect(File).to receive(:open).
        with('.env', 'a+').once.
        and_return(env_double)

      described_class.new.append('test2')
    end
  end
end
