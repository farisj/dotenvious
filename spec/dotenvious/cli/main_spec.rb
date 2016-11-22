require 'spec_helper'

describe Dotenvious::CLI::Main do
  describe '#run' do
    context 'with no flags' do
      before do
        allow(File).to receive(:read).and_return("")
        allow(STDIN).to receive(:gets).and_return('n')
      end

      it 'begins the EnvFileConsolidator' do
        expect_any_instance_of(Dotenvious::CLI::EnvFileConsolidator).to receive(:run)

        described_class.new.run
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
