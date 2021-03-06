require 'spec_helper'

describe Dotenvious::Prompter do
  describe '.run' do
    before(:each) do
      stub_const('Dotenvious::ENV', { 'test' => nil } )
      stub_const('Dotenvious::ENV_EXAMPLE', {'test' => nil, 'test2' => nil, 'test3' => nil} )
      # expect(Dotenvious::ENV).to receive(:keys).and_return(['test'])
      # expect(Dotenvious::ENV_EXAMPLE).to receive(:keys).and_return(['test', 'test2', 'test3'])
    end
    it 'prompts the user to add every missing or mismatched variable do' do
      expect(STDIN).to receive(:gets).twice.and_return('n')

      described_class.new.run
    end

    it 'appends the vars to .env' do
      expect(STDIN).to receive(:gets).twice.and_return('y','n')
      file_double = double
      expect(file_double).to receive(:write).with("test2=\n")
      expect(file_double).to receive(:close)

      expect(File).to receive(:open).
        with('.env', 'a+').once.
        and_return(file_double)

      described_class.new.run
    end

    it 'quits out if the user presses q' do
      expect(STDIN).to receive(:gets).once.and_return('q')

      described_class.new.run
    end

    xit 'given missing and different args, appends/rewrites correctly into env' do
    end
  end
end
