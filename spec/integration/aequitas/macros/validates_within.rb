require_relative '../../../spec_helper'
require_relative '../../shared/macros/integration_spec'
require 'aequitas'

Aequitas::Macros::IntegrationSpec.describe Aequitas::Macros, '#validates_within' do
  before do
    class_under_test.validates_within attribute_name, :set => Set[*set]
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
