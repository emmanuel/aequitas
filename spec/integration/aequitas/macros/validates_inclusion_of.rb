require 'spec_helper'

Aequitas::Macros::IntegrationSpec.describe Aequitas::Macros, '#validates_inclusion_of' do
  before do
    context_under_test.validates_inclusion_of attribute_name, :within => Set[*set]
  end

  let(:set) { [:a, :b, :c] }

  describe 'when validated attribute value is included in the set' do
    let(:attribute_value) { set.first }

    it_should_be_a_valid_instance
  end

  describe 'when validated attribute value is not included in the set' do
    let(:attribute_value) { :foo }

    it_should_be_an_invalid_instance
  end
end
