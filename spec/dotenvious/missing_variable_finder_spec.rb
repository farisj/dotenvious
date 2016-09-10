require 'spec_helper'

describe Dotenvious::MissingVariableFinder do
  describe '.missing_required_vars' do
    before(:each) do
      stub_const('Dotenvious::ENV', {'TEST' => 'same'} )
      stub_const('Dotenvious::ENV_EXAMPLE', {'TEST' => 'different', 'TEST_2' => 'value', 'TEST_3' => 'missing_value'} )
    end
    context 'with custom configuration' do
      before do
        stub_const('Dotenvious::CONFIG', { optional_vars: ['TEST_3'] } )
      end

      it 'ignores vars specified in CONFIG[:custom_variables]' do
        expect(described_class.missing_required_vars).to match_array(['TEST_2'])
      end
    end

    context 'without custom configuration' do
      it 'specifies any ENV_EXAMPLE vars that are missing from ENV' do
        expect(described_class.missing_required_vars).to match_array(['TEST_2', 'TEST_3'])
      end
    end
  end

  describe '.required_vars_missing?' do
    context 'given a loaded ENV and ENV_EXAMPLE' do
      before(:each) do
        stub_const('Dotenvious::ENV_EXAMPLE', {'test' => "123", 'example' => "234"} )
      end
      context 'where ENV has all variables' do
        it 'returns false' do
          allow(described_class).to receive(:missing_required_vars).and_return([])
          expect(described_class.required_vars_missing?).to eq false
        end
      end

      context 'where ENV is missing variables' do
        it 'returns true' do
          allow(described_class).to receive(:missing_required_vars).and_return(['test'])
          expect(described_class.required_vars_missing?).to eq true
        end
      end
    end
  end
end
