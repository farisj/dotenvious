require 'spec_helper'

describe Dotenvious::CLI do
  describe '.new' do
    xit 'determines the correct file to use as example' do
      # future release work
    end
  end

  describe '#run' do
    it 'loads the environment & example environment variables' do
      expect_any_instance_of(Dotenvious::Loader).to receive(:load_envs)

      described_class.new.run
    end

    context 'when there are ENV vars missing' do
      context 'and the user wants to append them' do
        it 'begins the EnvAppender' do
          io_object = double
          expect(STDIN).to receive(:gets).and_return('y')
          expect_any_instance_of(described_class).to receive(:all_vars_present?).and_return false
          expect(Dotenvious::EnvAppender).to receive(:run)#.and_return false
          described_class.new.run
        end
      end
      context 'but the user does not care' do
        it 'quits' do
          expect(STDIN).to receive(:gets).and_return('n')
          expect_any_instance_of(described_class).to receive(:all_vars_present?).and_return false
          expect(Dotenvious::EnvAppender).not_to receive(:run)#.and_return false

          described_class.new.run
        end
      end
    end

    context 'when there are no ENV vars missing' do
      it 'does nothing' do
        expect_any_instance_of(described_class).to receive(:all_vars_present?).and_return true

        expect { described_class.new.run }.to_not raise_error 
      end
    end
  end

  describe '#all_vars_present?' do
    it 'delegates to MissingVariableFinder' do
      expect(Dotenvious::MissingVariableFinder).to receive(:all_vars_present?).and_return true

      described_class.new.run
    end
  end
end