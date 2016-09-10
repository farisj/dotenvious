require 'spec_helper'

describe Dotenvious::MismatchedVariableFinder do
  describe '.mismatched_vars' do
    before do
      stub_const('Dotenvious::ENV', {'test' => 'test_value', 'test_2' => 'same'} )
      stub_const('Dotenvious::ENV_EXAMPLE', {'test_2' => 'different', 'test_3' => 'test_value'} )
    end
    context 'without custom configuration' do
      it 'returns array of keys whose values are mismatched ENV & ENV_EXAMPLE' do
        expect(described_class.mismatched_vars).to match_array(['test_2'])
      end
    end

    context 'with custom configuration' do
      before do
        stub_const('Dotenvious::ENV', {'TEST' => 'same', 'TEST_2' => 'some_value'} )
        stub_const('Dotenvious::ENV_EXAMPLE', {'TEST' => 'different', 'TEST_2' => 'different_value'} )
        stub_const('Dotenvious::CONFIG', { custom_variables: ['TEST'] } )
      end

      it 'ignores vars specified in CONFIG[:custom_variables]' do
        expect(described_class.mismatched_vars).to match_array(['TEST_2'])
      end
    end
  end

  describe '.mismatched_vars?' do
    it 'returns true if mismatched_vars are present' do
      expect(described_class).to receive(:mismatched_vars).and_return(['asdf'])

      expect(described_class.mismatched_vars?).to be true
    end

    it 'returns false if mismatched_vars are not present' do
      expect(described_class).to receive(:mismatched_vars).and_return([])

      expect(described_class.mismatched_vars?).to be false
    end
  end
end
