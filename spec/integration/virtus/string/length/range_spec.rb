require 'spec_helper'

describe Aequitas::VirtusIntegration::ClassMethods do
  let(:class_under_test) do
    Class.new do
      include Virtus
      include Aequitas

      attribute :validated_attribute, String, :length => 1..3

      self
    end
  end

  describe '.validation_rules' do
    it 'includes a Rule::Length::Range for :boolean_with_presence' do
      attribute_rules = class_under_test.validation_rules[:validated_attribute]
      refute_predicate attribute_rules, :empty?
      assert_instance_of Aequitas::Rule::Length::Range, attribute_rules.first
    end
  end

  describe '#valid?' do
    subject { class_under_test.new(:validated_attribute => attribute_value) }

    describe 'when empty string' do
      let(:attribute_value) { '' }
      it('is not valid') { refute_predicate subject, :valid? }
    end

    describe 'when nil' do
      let(:attribute_value) { nil }
      it('is not valid') { refute_predicate subject, :valid? }
    end

    describe 'when a string of length within the range' do
      let(:attribute_value) { 'foo' }
      it('is valid') { assert_predicate subject, :valid? }
    end

    describe 'when a string of length outside the range' do
      let(:attribute_value) { 'quux' }
      it('is not valid') { refute_predicate subject, :valid? }
    end
  end
end
