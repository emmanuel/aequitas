require_relative '../../../spec_helper'
require 'virtus'
require 'aequitas'
require 'aequitas/virtus'

describe Aequitas::Virtus::ClassMethodOverrides do
  let(:class_under_test) do
    Class.new do
      include Virtus
      include Aequitas

      attribute :validated_attribute, 'Boolean', :required => true

      self
    end
  end

  describe '.validation_rules' do
    it 'includes a Rule::Presence::NotNil for :validated_attribute' do
      attribute_rules = class_under_test.validation_rules[:validated_attribute]
      refute_predicate attribute_rules, :empty?
      assert_instance_of Aequitas::Rule::Presence::NotNil, attribute_rules.first
    end
  end

  describe '#valid?' do
    subject { class_under_test.new(:validated_attribute => attribute_value) }

    describe 'when empty string' do
      let(:attribute_value) { '' }
      it('is valid') { assert_predicate subject, :valid? }
    end

    describe 'when nil' do
      let(:attribute_value) { nil }
      it('is not valid') { refute_predicate subject, :valid? }
    end

    describe 'when false' do
      let(:attribute_value) { false }
      it('is valid') { assert_predicate subject, :valid? }
    end

    describe 'when true' do
      let(:attribute_value) { true }
      it('is valid') { assert_predicate subject, :valid? }
    end
  end
end
