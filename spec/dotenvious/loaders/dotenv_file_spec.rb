require 'spec_helper'

describe Dotenvious::Loaders::DotenvFile do
  describe '.load_from' do
    context 'given a file which does not exist' do
      before do
        expect(File).to receive(:exists?).and_return false
      end
      it 'aborts the process' do
        described_class.load_from('.env')
      end
    end

    context 'given a file which exists' do
      before do
        expect(File).to receive(:exists?).and_return true
      end

      it 'reads the given Dotenv format file and returns hash' do
        expect(File).to receive(:read).and_return "TEST=123\nEXAMPLE=234"

        response = described_class.load_from('.env')

        expect(response['TEST']).to eq '123'
        expect(response['EXAMPLE']).to eq '234'
      end
    end
  end
end
