require_relative '../../../spec_helper'
require 'virtus'
require 'aequitas'
require 'aequitas/virtus'

describe Aequitas::Virtus::ClassMethodOverrides do
  let(:class_under_test) do
    class ClassUnderTest
      include Virtus
      include Aequitas

      attribute :boolean_with_presence, Boolean,  :required => true

      self
    end
  end

  describe '.validation_rules' do
    it 'includes a Rule::Presence::NotNil for :boolean_with_presence' do
      attribute_rules = class_under_test.validation_rules[:boolean_with_presence]
      refute_predicate attribute_rules, :empty?
      assert_instance_of Aequitas::Rule::Presence::NotNil, attribute_rules.first
    end
  end

  describe '#boolean_with_presence' do
    subject { class_under_test.new(:boolean_with_presence => attribute_value) }

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
