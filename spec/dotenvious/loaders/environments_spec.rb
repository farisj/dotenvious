require 'spec_helper'

describe Dotenvious::Loaders::Environments do
  describe '#initialize' do
    it 'takes 1 argument' do
      expect { described_class.new('test') }.to_not raise_error
    end
  end

  describe '#load_envs' do
    it 'loads from Dotenv as well as Loaders::Example' do
      expect_any_instance_of(Dotenvious::Loaders::Example).to receive(:load)
      expect_any_instance_of(Dotenvious::Loaders::Env).to receive(:load)

      described_class.new('test').load_envs
    end
  end
end
