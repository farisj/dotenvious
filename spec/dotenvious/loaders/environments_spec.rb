require 'spec_helper'

describe Dotenvious::Loaders::Environments do
  describe '#load_environments' do
    it 'loads from Dotenv as well as Loaders::Example' do
      expect(Dotenvious::Loaders::DotenvFile).to receive(:load_from).with('.env').and_return({})
      expect(Dotenvious::Loaders::DotenvFile).to receive(:load_from).with('.example-env').and_return({})

      described_class.new.load_environments
    end
  end
end
