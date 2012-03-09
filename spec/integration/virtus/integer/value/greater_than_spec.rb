require 'spec_helper'
require 'virtus'
require 'aequitas'
require 'aequitas/virtus_integration'

describe Aequitas::VirtusIntegration::ClassMethods do
  let(:class_under_test) do
    Class.new do
      include Virtus
      include Aequitas

      attribute :validated_attribute, Integer, :greater_than => 3

      self
    end
  end

  describe '.validation_rules' do
    it 'includes the expected Rule for :validated_attribute' do
      attribute_rules = class_under_test.validation_rules[:validated_attribute]
      refute_predicate attribute_rules, :empty?
      assert_instance_of Aequitas::Rule::Value::GreaterThan, attribute_rules.first
    end
  end

  describe '#valid?' do
    subject { class_under_test.new(:validated_attribute => attribute_value) }

    describe 'when value is less than expected' do
      let(:attribute_value) { 1 }
      it('is not valid') { refute_predicate subject, :valid? }
    end

    describe 'when value is equal to expected' do
      let(:attribute_value) { 3 }
      it('is not valid') { refute_predicate subject, :valid? }
    end

    describe 'when value is greater than expected' do
      let(:attribute_value) { 5 }
      it('is valid') { assert_predicate subject, :valid? }
    end

  end
end
