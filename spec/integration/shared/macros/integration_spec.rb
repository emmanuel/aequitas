require 'minitest/spec'

module Aequitas
  module Macros
    class IntegrationSpec < MiniTest::Spec
      class << self; public :describe; end

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
      let(:class_of_violated_validation_rule) do
        class_under_test.validation_rules[attribute_name].first.class
      end
      let(:validation_rules) do
        class_under_test.validation_rules[attribute_name].select do |rule|
          rule.instance_of?(class_of_violated_validation_rule)
        end
      end
      let(:expected_violations) do
        validation_rules.map { |rule| Violation::Rule.new(subject, nil, :rule => rule) }
      end

      subject { class_under_test.new(attribute_value) }

      def self.it_should_be_a_valid_instance
        it '#valid? returns true' do
          assert_predicate subject, :valid?
        end

        it '#errors is empty' do
          assert_predicate subject.validate.errors, :empty?
        end

        it 'errors on attribute name is empty' do
          assert_predicate subject.validate.errors.on(attribute_name), :empty?
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
          assert_equal expected_violations, subject.validate.errors.on(attribute_name)
        end

        it "the expected violation's message contains the attribute name" do
          message = subject.validate.errors.on(attribute_name).first.message
          assert_includes message, attribute_name.to_s
        end
      end

    end # class IntegrationSpec
  end # module Macros
end # module Aequitas
