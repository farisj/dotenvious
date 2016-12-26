require 'spec_helper'

describe Dotenvious::CLI::Main do
  describe '#run' do
    context 'with no flags' do
      before do
        allow(File).to receive(:read).and_return("")
      end

      it 'begins the EnvFileConsolidator' do
        expect_any_instance_of(Dotenvious::CLI::EnvFileConsolidator).to receive(:run)

        described_class.new.run
      end
    end

    context 'when option flags are given' do
      context 'and the flag is not implemented' do
        before do
          stub_const('ARGV', ['--test'])
        end

        it 'ignores the flag and runs main process' do
          expect_any_instance_of(Dotenvious::CLI::EnvFileConsolidator).to receive(:run)

          described_class.new.run
        end
      end

      context 'and the flag is implemented' do
        context '--sort' do
          before do
            stub_const('ARGV', ['--sort'])
          end

          it 'runs EnvFileSorter after main process' do
            expect_any_instance_of(Dotenvious::CLI::EnvFileConsolidator).to receive(:run)
            expect_any_instance_of(Dotenvious::CLI::EnvFileSorter).to receive(:run)

            described_class.new.run
          end
        end
      end
    end
  end
end
