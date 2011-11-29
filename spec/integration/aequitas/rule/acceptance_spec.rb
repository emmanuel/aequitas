require_relative '../../../spec_helper'
require 'aequitas'

module Aequitas
  class Rule
    describe Acceptance do
      let(:class_under_test) do
        attribute_name = self.attribute_name

        Class.new do
          include Aequitas

          validates_acceptance_of attribute_name

          attr_accessor attribute_name

          define_method(:initialize) do |attribute_value|
            send("#{attribute_name}=", attribute_value)
          end
        end
      end

      let(:attribute_name) { :absence_attribute }
      let(:validation_rule) { class_under_test.validation_rules[attribute_name].first }
      let(:expected_violation) { Violation.new(subject, nil, validation_rule) }

      subject { class_under_test.new(attribute_value) }

      describe 'when attribute value is accepted' do
        let(:attribute_value) { true }

        it '#valid? returns true' do
          assert_predicate subject, :valid?
        end

        it '#errors is empty' do
          assert_predicate subject.validate.errors, :empty?
        end
      end

      describe 'when attribute value is not accepted' do
        let(:attribute_value) { false }

        it '#valid? returns false' do
          refute_predicate subject, :valid?
        end

        it '#errors is not empty' do
          refute_predicate subject.validate.errors, :empty?
        end

        it '#errors has one member' do
          assert_equal 1, subject.validate.errors.size
        end

        it 'has a violation under the expected attribute name' do
          assert_equal [expected_violation], subject.validate.errors.on(attribute_name)
        end
      end
    end
  end # class Rule
end # module Aequitas
