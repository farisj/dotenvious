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

  describe '#custom_variables=' do
    it 'sets :custom_variables in CONFIG' do
      described_class.new do |config|
        config.custom_variables = %w(TEST VARS)
      end

      expect(Dotenvious::CONFIG[:custom_variables]).to eq ['TEST', 'VARS']
    end

    it 'only accepts an array of all caps strings' do
      expect do
        described_class.new do |config|
          config.custom_variables = 'idk'
        end
      end.to raise_error Dotenvious::Configuration::ConfigurationError

      expect do
        described_class.new do |config|
          config.custom_variables = [:symbol]
        end
      end.to raise_error Dotenvious::Configuration::ConfigurationError

      expect do
        described_class.new do |config|
          config.custom_variables = ['lower', 'case']
        end
      end.to raise_error Dotenvious::Configuration::ConfigurationError
    end
  end

  describe '#optional_variables=' do
    it 'sets :optional_variables in CONFIG' do
      described_class.new do |config|
        config.optional_variables = %w(TEST VARS)
      end

      expect(Dotenvious::CONFIG[:optional_variables]).to eq ['TEST', 'VARS']
    end

    it 'only accepts an array of all caps strings' do
      expect do
        described_class.new do |config|
          config.optional_variables = 'idk'
        end
      end.to raise_error Dotenvious::Configuration::ConfigurationError

      expect do
        described_class.new do |config|
          config.optional_variables = [:symbol]
        end
      end.to raise_error Dotenvious::Configuration::ConfigurationError

      expect do
        described_class.new do |config|
          config.optional_variables = ['lower', 'case']
        end
      end.to raise_error Dotenvious::Configuration::ConfigurationError
    end
  end
end
