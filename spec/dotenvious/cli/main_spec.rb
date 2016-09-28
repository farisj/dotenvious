require 'spec_helper'

describe Dotenvious::CLI::Main do
  describe '.new' do
    xit 'determines the correct file to use as example' do
      # future release work
    end
  end

  describe '#run' do
    context 'with no flags' do
      before do
        allow(File).to receive(:read).and_return("")
      end

      it 'loads the environment & example environment variables' do
        expect_any_instance_of(Dotenvious::Loaders::Environments).to receive(:load_envs)

        described_class.new.run
      end

      context 'when there are ENV vars missing' do
        context 'and the user wants to append them' do
          it 'begins the Prompter' do
            io_object = double
            expect(STDIN).to receive(:gets).and_return('y')
            expect_any_instance_of(described_class).to receive(:all_vars_present?).and_return false
            expect(Dotenvious::Prompter).to receive(:run)#.and_return false
            described_class.new.run
          end
        end

        context 'but the user does not care' do
          it 'quits' do
            expect(STDIN).to receive(:gets).and_return('n')
            expect_any_instance_of(described_class).to receive(:all_vars_present?).and_return false
            expect(Dotenvious::Prompter).not_to receive(:run)#.and_return false

            described_class.new.run
          end
        end
      end

      context 'when there are no ENV vars missing or mismatched' do
        it 'does nothing' do
          expect_any_instance_of(described_class).to receive(:all_vars_present?).and_return true
          expect_any_instance_of(described_class).to receive(:all_vars_match?).and_return true

          expect { described_class.new.run }.to_not raise_error
        end
      end
    end

    context 'when option flags are given' do
      before do
        stub_const('ARGV', ['--test'])
      end

      it 'tells the user to try again without flags' do
        expect_any_instance_of(described_class).to receive(:ask_user_to_remove_flags)

        described_class.new.run
      end
    end
  end
end
