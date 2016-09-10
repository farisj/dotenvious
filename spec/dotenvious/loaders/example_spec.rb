require 'spec_helper'

describe Dotenvious::Loaders::Example do
  describe '.new' do
    it 'takes one argument' do
      expect{ described_class.new('test') }.to_not raise_error
    end
  end

  describe '#load' do
    it 'loads files from its .new argument' do
      expect(File).to receive(:read).with('test').and_return ""

      described_class.new('test').load
    end

    it 'passes those arguments to Dotenvious::ENV_EXAMPLE' do
      expect(File).to receive(:read).and_return "TEST=123\nEXAMPLE=234"

      described_class.new('test').load

      expect(Dotenvious::ENV_EXAMPLE['TEST']).to eq '123'
      expect(Dotenvious::ENV_EXAMPLE['EXAMPLE']).to eq '234'
    end
  end
end
