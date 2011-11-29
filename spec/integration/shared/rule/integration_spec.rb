require 'minitest/spec'

module Aequitas
  class Rule
    class IntegrationSpec < MiniTest::Spec
      let(:class_under_test) do
        attribute_name = self.attribute_name

        Class.new do
          include Aequitas

          attr_accessor attribute_name

          define_method(:initialize) do |attribute_value|
            send("#{attribute_name}=", attribute_value)
          end
        end
      end

      let(:attribute_name) { :attribute_under_test }
      let(:validation_rule) { class_under_test.validation_rules[attribute_name].first }
      let(:expected_violation) { Violation.new(subject, nil, validation_rule) }

      subject { class_under_test.new(attribute_value) }

      def self.it_should_be_a_valid_instance
        it '#valid? returns true' do
          assert_predicate subject, :valid?
        end

        it '#errors is empty' do
          assert_predicate subject.validate.errors, :empty?
        end
      end

      def self.it_should_be_an_invalid_instance
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

    end # class IntegrationSpec
  end # class Rule
end # module Aequitas
