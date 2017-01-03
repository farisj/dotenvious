require 'spec_helper'

describe Dotenvious::CLI::EnvFileSorter do
  describe '#run' do
    it "sorts the key-value pairs back into .env" do
      stub_const('Dotenvious::ENV', {'TEST' => 'same', 'ABC' => '123'} )

      fake_file = double
      expect(fake_file).to receive(:write).with("ABC=123\nTEST=same")
      expect(File).to receive(:open).with('.env', 'w').and_yield fake_file

      described_class.new.run
    end
  end
end
