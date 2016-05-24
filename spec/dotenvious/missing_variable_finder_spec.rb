require 'spec_helper'

describe Dotenvious::MissingVariableFinder do
  describe '.all_vars_present?' do
    context 'given a loaded ENV and ENV_EXAMPLE' do
      before(:each) do
        stub_const('Dotenvious::ENV_EXAMPLE', {'test' => "123", 'example' => "234"} )
      end
      context 'where ENV has all variables' do
        it 'returns true' do
          stub_const('ENV', {'test' => "123", 'example' => "234"})
          expect(described_class.all_vars_present?).to eq true
        end
      end

      context 'where ENV is missing variables' do
        it 'returns false' do
          stub_const('ENV', {'test' => "123"})
          expect(described_class.all_vars_present?).to eq false
        end
      end
    end
  end
end