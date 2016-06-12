require 'spec_helper'

describe Dotenvious::Configuration do
  before(:each) do
    stub_const('Dotenvious::CONFIG', {} )
  end
  describe '#example_file=' do
    it 'sets :example_file in CONFIG' do
      described_class.new do |config|
        config.example_file = 'test_file.txt'
      end

      expect(Dotenvious::CONFIG[:example_file]).to eq 'test_file.txt'
    end

    it 'only accepts a string' do
      expect do
        described_class.new do |config|
          config.example_file = 1
        end
      end.to raise_error Dotenvious::Configuration::ConfigurationError
    end
  end

  describe '#ignored_vars=' do
    it 'sets :ignored_vars in CONFIG' do
      described_class.new do |config|
        config.ignored_vars = %w(TEST VARS)
      end

      expect(Dotenvious::CONFIG[:ignored_vars]).to eq ['TEST', 'VARS']
    end

    it 'only accepts an array of all caps strings' do
      expect do
        described_class.new do |config|
          config.ignored_vars = 'idk'
        end
      end.to raise_error Dotenvious::Configuration::ConfigurationError

      expect do
        described_class.new do |config|
          config.ignored_vars = [:symbol]
        end
      end.to raise_error Dotenvious::Configuration::ConfigurationError

      expect do
        described_class.new do |config|
          config.ignored_vars = ['lower', 'case']
        end
      end.to raise_error Dotenvious::Configuration::ConfigurationError
    end
  end

  describe '#optional_vars=' do
    it 'sets :optional_vars in CONFIG' do
      described_class.new do |config|
        config.optional_vars = %w(TEST VARS)
      end

      expect(Dotenvious::CONFIG[:optional_vars]).to eq ['TEST', 'VARS']
    end

    it 'only accepts an array of all caps strings' do
      expect do
        described_class.new do |config|
          config.optional_vars = 'idk'
        end
      end.to raise_error Dotenvious::Configuration::ConfigurationError

      expect do
        described_class.new do |config|
          config.optional_vars = [:symbol]
        end
      end.to raise_error Dotenvious::Configuration::ConfigurationError

      expect do
        described_class.new do |config|
          config.optional_vars = ['lower', 'case']
        end
      end.to raise_error Dotenvious::Configuration::ConfigurationError
    end
  end
end
