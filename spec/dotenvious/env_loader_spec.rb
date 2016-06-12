require 'spec_helper'

describe Dotenvious::EnvLoader do
  describe '#initialize' do
    it 'takes 1 argument' do
      expect { described_class.new('test') }.to_not raise_error
    end
  end

  describe '#load_envs' do
    it 'loads from Dotenv as well as ExampleLoader' do
      expect(Dotenv).to receive(:load)
      expect_any_instance_of(Dotenvious::ExampleLoader).to receive(:load)

      described_class.new('test').load_envs
    end
  end
end