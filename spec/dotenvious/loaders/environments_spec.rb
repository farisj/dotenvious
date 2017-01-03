require 'spec_helper'

describe Dotenvious::Loaders::Environments do
  describe '#new' do
    it 'takes options hash' do
      expect{ described_class.new({example_file: '.my.example.file'}) }.to_not raise_error
    end
  end

  describe '#load_environments' do
    context 'without user-specified example file' do
      it 'loads from Dotenv as well as Loaders::Example' do
        expect(Dotenvious::Loaders::DotenvFile).to receive(:load_from).with('.env').and_return({})
        expect(Dotenvious::Loaders::DotenvFile).to receive(:load_from).with('.example-env').and_return({})

        described_class.new.load_environments
      end
    end

    context 'with user-specified example file' do
      it 'loads that example environment' do
        expect(Dotenvious::Loaders::DotenvFile).to receive(:load_from).with('.env').and_return({})
        expect(Dotenvious::Loaders::DotenvFile).to receive(:load_from).with('.my.example.file').and_return({})

        described_class.new({example_file: '.my.example.file'}).load_environments
      end
    end
  end
end
