require 'spec_helper'

describe Dotenvious::Loaders::YamlFile do
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

      it 'reads the given Yaml format file and returns hash' do
        expect(YAML).to receive(:load_file).and_return ({
          "machine" => {
            "environment" => {
              "TEST" => 123,
              "EXAMPLE" => 234
            }
          }
        })

        response = described_class.load_from('production.yaml')

        expect(response['TEST']).to eq '123'
        expect(response['EXAMPLE']).to eq '234'
      end
    end
  end
end
