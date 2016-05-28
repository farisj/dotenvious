require 'spec_helper'

describe Dotenvious::EnvAppender do
  describe '.run' do
    before(:each) do
      stub_const('Dotenvious::ENV', {} )
      stub_const('Dotenvious::ENV_EXAMPLE', {} )
      expect(Dotenvious::ENV).to receive(:keys).and_return(['test'])
      expect(Dotenvious::ENV_EXAMPLE).to receive(:keys).and_return(['test', 'test2', 'test3'])
    end
    it 'prompts the user to add every missing variable do' do
      expect(STDIN).to receive(:gets).twice.and_return('n')

      described_class.run
    end

    it 'appends the vars to .env' do
      expect(STDIN).to receive(:gets).twice.and_return('y','n')
      expect(File).to receive(:open).
        with('.env', 'a+').once.
        and_return(double('File', write: nil))

      described_class.run
    end

    it 'quits out if the user presses q' do
      expect(STDIN).to receive(:gets).once.and_return('q')

      described_class.run
    end
  end
end