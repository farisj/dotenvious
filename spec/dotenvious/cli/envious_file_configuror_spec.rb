require 'spec_helper'

describe Dotenvious::CLI::EnviousFileConfiguror do
  describe '#run' do
    context 'when no .envious file exists' do
      before do
        allow(File).to receive(:exist?).with('.envious').and_return false
      end

      context 'and the user wants to create an .envious file' do
        before do
          expect(STDIN).to receive(:gets).and_return "y"
        end
        it 'creates the file' do
          fake_file = double(File)
          expect(File).to receive(:open).and_yield fake_file
          expect(fake_file).to receive(:write)

          described_class.new.run
        end
      end

      context 'but the user does not want to create an .envious file' do
        before do
          expect(STDIN).to receive(:gets).and_return "n"
        end
        it 'does nothing' do
          expect(File).not_to receive(:open)

          described_class.new.run
        end
      end
    end

    context 'when an .envious file exists' do
      before do
         allow(File).to receive(:exist?).with('.envious').and_return true
      end
      it 'does not prompt or do anything' do
        expect(STDIN).not_to receive(:gets)

        described_class.new.run
      end
    end
  end
end
