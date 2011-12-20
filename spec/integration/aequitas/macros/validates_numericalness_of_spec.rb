require_relative '../../../spec_helper'
require_relative '../../shared/macros/integration_spec'
require 'aequitas'

Aequitas::Macros::IntegrationSpec.describe Aequitas::Macros, '#validates_numericalness_of' do
  describe 'with no options' do
    before do
      class_under_test.validates_numericalness_of attribute_name
    end

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

  describe 'with :eq, :equal, :equals, :exactly, or :equal_to options' do
    before do
      class_under_test.validates_numericalness_of attribute_name, :eq => bound
    end

    let(:bound) { 1 }
    let(:class_of_violated_validation_rule) do
      Aequitas::Rule::Value::Equal
    end

    describe 'when validated attribute is greater than bound' do
      let(:attribute_value) { bound + 1 }

      it_should_be_an_invalid_instance
    end

    describe 'when validated attribute is equal to bound' do
      let(:attribute_value) { bound }

      it_should_be_a_valid_instance
    end

    describe 'when validated attribute is less than bound' do
      let(:attribute_value) { bound - 1 }

      it_should_be_an_invalid_instance
    end
  end

  describe 'with :ne or :not_equal_to options' do
    before do
      class_under_test.validates_numericalness_of attribute_name, :ne => bound
    end

    let(:bound) { 1 }
    let(:class_of_violated_validation_rule) do
      Aequitas::Rule::Value::NotEqual
    end

    describe 'when validated attribute is greater than bound' do
      let(:attribute_value) { bound + 1 }

      it_should_be_a_valid_instance
    end

    describe 'when validated attribute is equal to bound' do
      let(:attribute_value) { bound }

      it_should_be_an_invalid_instance
    end

    describe 'when validated attribute is less than bound' do
      let(:attribute_value) { bound - 1 }

      it_should_be_a_valid_instance
    end
  end

  describe 'with :gt or :greater_than options' do
    before do
      class_under_test.validates_numericalness_of attribute_name, :gt => bound
    end

    let(:bound) { 1 }
    let(:class_of_violated_validation_rule) do
      Aequitas::Rule::Value::GreaterThan
    end

    describe 'when validated attribute is greater than bound' do
      let(:attribute_value) { bound + 1 }

      it_should_be_a_valid_instance
    end

    describe 'when validated attribute is equal to bound' do
      let(:attribute_value) { bound }

      it_should_be_an_invalid_instance
    end

    describe 'when validated attribute is less than bound' do
      let(:attribute_value) { bound - 1 }

      it_should_be_an_invalid_instance
    end
  end

  describe 'with :lt or :less_than options' do
    before do
      class_under_test.validates_numericalness_of attribute_name, :lt => bound
    end

    let(:bound) { 1 }
    let(:class_of_violated_validation_rule) do
      Aequitas::Rule::Value::LessThan
    end

    describe 'when validated attribute is greater than bound' do
      let(:attribute_value) { bound + 1 }

      it_should_be_an_invalid_instance
    end

    describe 'when validated attribute is equal to bound' do
      let(:attribute_value) { bound }

      it_should_be_an_invalid_instance
    end

    describe 'when validated attribute is less than bound' do
      let(:attribute_value) { bound - 1 }

      it_should_be_a_valid_instance
    end
  end

  describe 'with :gte or :greater_than_or_equal_to options' do
    before do
      class_under_test.validates_numericalness_of attribute_name, :gte => bound
    end

    let(:bound) { 1 }
    let(:class_of_violated_validation_rule) do
      Aequitas::Rule::Value::GreaterThanOrEqual
    end

    describe 'when validated attribute is greater than bound' do
      let(:attribute_value) { bound + 1 }

      it_should_be_a_valid_instance
    end

    describe 'when validated attribute is equal to bound' do
      let(:attribute_value) { bound }

      it_should_be_a_valid_instance
    end

    describe 'when validated attribute is less than bound' do
      let(:attribute_value) { bound - 1 }

      it_should_be_an_invalid_instance
    end
  end

  describe 'with :lte or :less_than_or_equal_to options' do
    before do
      class_under_test.validates_numericalness_of attribute_name, :lte => bound
    end

    let(:bound) { 1 }
    let(:class_of_violated_validation_rule) do
      Aequitas::Rule::Value::LessThanOrEqual
    end

    describe 'when validated attribute is greater than bound' do
      let(:attribute_value) { bound + 1 }

      it_should_be_an_invalid_instance
    end

    describe 'when validated attribute is equal to bound' do
      let(:attribute_value) { bound }

      it_should_be_a_valid_instance
    end

    describe 'when validated attribute is less than bound' do
      let(:attribute_value) { bound - 1 }

      it_should_be_a_valid_instance
    end
  end
end
