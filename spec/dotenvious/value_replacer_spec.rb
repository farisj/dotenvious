require 'spec_helper'

describe Dotenvious::ValueReplacer do
  describe '#replace' do
    before do
      stub_const('Dotenvious::ENV_EXAMPLE', example_const )
    end
    context 'given a key with a different value' do
      let(:example_const) { {'fake' => 'correct'} }
      it "replaces the key's value in .env if user presses yes" do
        expect(File).to receive(:read).
          with('.big-ol-env').
          and_return("test=1234\nfake=missing")

        env_double = double('File', write: nil)
        expect(env_double).to receive(:write).with("test=1234\nfake=correct\n")

        expect(File).to receive(:open).
          with('.big-ol-env', 'w').
          and_return(env_double)

        described_class.new('.big-ol-env').replace('fake')
      end
    end
  end
end
