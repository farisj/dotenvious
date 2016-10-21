require 'spec_helper'

describe Dotenvious::Loaders::Environments do
  describe '#load_envs' do
    it 'loads from Dotenv as well as Loaders::Example' do
      expect_any_instance_of(Dotenvious::Loaders::Example).to receive(:load)
      expect_any_instance_of(Dotenvious::Loaders::Env).to receive(:load)

      described_class.new.load_envs
    end
  end
end
