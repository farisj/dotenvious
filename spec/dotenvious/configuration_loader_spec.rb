require 'spec_helper'

describe Dotenvious::ConfigurationLoader do
  describe '#load' do
    let(:filepath) { Dir.pwd + '/.envious' }
    context 'when ./.envious is present' do
      before do
        allow(File).to receive(:file?).with(filepath).and_return true
      end
      it 'loads the file' do
        expect(Kernel).to receive(:load).with(filepath)

        described_class.new.load
      end
    end

    context 'when ./.envious is not present' do
      before do
        allow(File).to receive(:file?).with(filepath).and_return false
      end
      it 'does nothing' do
        expect(Kernel).not_to receive(:require)

        described_class.new.load
      end
    end
  end
end
