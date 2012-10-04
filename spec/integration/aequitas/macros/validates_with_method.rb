require 'spec_helper'

Aequitas::Macros::IntegrationSpec.describe Aequitas::Macros, '#validates_with_method' do
  before { class_under_test.validates_with_method attribute_name }

  describe 'when method returns a truthy value' do
    let(:attribute_value) { true }

    it_should_be_a_valid_instance
  end

  describe 'when method returns a falsy value' do
    let(:attribute_value) { false }

    it_should_be_an_invalid_instance
  end
end
