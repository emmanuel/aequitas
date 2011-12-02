require_relative '../../../spec_helper'
require_relative '../../shared/macros/integration_spec'
require 'aequitas'

Aequitas::Macros::IntegrationSpec.describe Aequitas::Macros, '#validates_presence_of' do
  before { class_under_test.validates_presence_of attribute_name }

  describe 'when validated attribute is present' do
    let(:attribute_value) { :foo }

    it_should_be_a_valid_instance
  end

  describe 'when validated attribute is absent' do
    let(:attribute_value) { nil }

    it_should_be_an_invalid_instance
  end
end
