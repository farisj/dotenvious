require 'spec_helper'

describe Dotenvious::Loaders::Example do
  describe '#load' do
    before do
      stub_const('Dotenvious::DEFAULT_EXAMPLE_ENV_FILE', '.example-env')
    end
    it 'loads files from Dotenvious::DEFAULT_EXAMPLE_ENV_FILE' do
      expect(File).to receive(:read).with('.example-env').and_return ""

      described_class.new.load
    end

    it 'passes those arguments to Dotenvious::ENV_EXAMPLE' do
      expect(File).to receive(:read).and_return "TEST=123\nEXAMPLE=234"

      described_class.new.load

      expect(Dotenvious::ENV_EXAMPLE['TEST']).to eq '123'
      expect(Dotenvious::ENV_EXAMPLE['EXAMPLE']).to eq '234'
    end
  end
end
