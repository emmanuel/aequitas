require_relative '../../../spec_helper'
require_relative '../../shared/macros/integration_spec'
require 'aequitas'

Aequitas::Macros::IntegrationSpec.describe Aequitas::Macros, '#validates_numericalness_of' do
  describe 'with no options' do
    before do
      class_under_test.validates_numericalness_of attribute_name
    end

    let(:bound) { 1 }

    describe 'when validated attribute is a non-integer number' do
      let(:attribute_value) { 1.0 }

      it_should_be_a_valid_instance
    end

    describe 'when validated attribute is an integer' do
      let(:attribute_value) { 1 }

      it_should_be_a_valid_instance
    end

    describe 'when validated attribute is non-numeric' do
      let(:attribute_value) { 'a' }

      it_should_be_an_invalid_instance
    end
  end

  describe 'with :only_integer option' do
    before do
      class_under_test.validates_numericalness_of attribute_name, :only_integer => true
    end

    describe 'when validated attribute is an integer' do
      let(:attribute_value) { 1 }

      it_should_be_a_valid_instance
    end

    describe 'when validated attribute is not an integer' do
      let(:attribute_value) { 'a' }

      it_should_be_an_invalid_instance
    end
  end
end
