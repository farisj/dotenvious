require 'spec_helper'

describe Dotenvious::Loaders::Env do
  describe '#load' do
    context 'when .env are not present' do
      before do
        expect(File).to receive(:exists?).and_return false
      end
      it 'aborts the process' do
        described_class.new.load
      end
    end

    context 'when .env is present' do
      before do
        expect(File).to receive(:exists?).and_return true
      end
      it 'loads files from .env' do
        expect(File).to receive(:read).with('.env').and_return ""

        described_class.new.load
      end

      it 'passes those arguments to Dotenvious::ENV_EXAMPLE' do
        expect(File).to receive(:read).and_return "TEST=123\nEXAMPLE=234"

        described_class.new.load

        expect(Dotenvious::ENV['TEST']).to eq '123'
        expect(Dotenvious::ENV['EXAMPLE']).to eq '234'
      end
    end
  end
end
