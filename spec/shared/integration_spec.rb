require 'minitest/spec'

module Aequitas
  module Macros
    module IntegrationSpec
      def self.describe(*args, &block)
        IntegrationSpecStandalone.describe(*args, &block)
        IntegrationSpecExternal.describe(*args, &block)
      end
    end

    class IntegrationSpecShared < MiniTest::Spec
      class << self; public :describe; end

      let(:validation_rules) do
        context_under_test.validation_rules[attribute_name].select do |rule|
          rule.instance_of?(class_of_violated_validation_rule)
        end
      end

      let(:class_of_violated_validation_rule) do
        context_under_test.validation_rules[attribute_name].first.class
      end

      let(:attribute_name) { :attribute_under_test }

      let(:expected_violations) do
        validation_rules.map { |rule| Violation::Rule.new(subject, nil, :rule => rule) }
      end

    end

    class IntegrationSpecStandalone < IntegrationSpecShared

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

      let(:context_under_test) { class_under_test }

      let(:resource) { class_under_test.new(attribute_value) }

      subject { resource }

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

    end 

    class IntegrationSpecExternal < IntegrationSpecShared

      let(:class_under_test) do
        attribute_name = self.attribute_name

        Class.new do
          def inspect; 'Resource'; end

          attr_accessor attribute_name

          define_method(:initialize) do |attribute_value|
            send("#{attribute_name}=", attribute_value)
          end
        end
      end

      let(:context_under_test) do
        Class.new do
          def inspect; 'Validator'; end
          include Aequitas::Validator
        end
      end

      let(:resource) { class_under_test.new(attribute_value) }

      subject { context_under_test.new(resource) }

      def self.it_should_be_a_valid_instance
        it '#valid? returns true' do
          assert_predicate subject, :valid?
        end

        it '#errors is empty' do
          assert_predicate subject.violations, :empty?
        end

        it 'errors on attribute name is empty' do
          assert_predicate subject.violations.on(attribute_name), :empty?
        end
      end

      def self.it_should_be_an_invalid_instance
        it '#valid? returns false' do
          refute_predicate subject, :valid?
        end

        it '#errors is not empty' do
          refute_predicate subject.violations, :empty?
        end

        it '#errors has one member' do
          assert_equal 1, subject.violations.size
        end

        it 'has a violation under the expected attribute name' do
          assert_equal expected_violations, subject.violations.on(attribute_name)
        end

        it "the expected violation's message contains the attribute name" do
          message = subject.violations.on(attribute_name).first.message
          assert_includes message, attribute_name.to_s
        end
      end

    end
  end 
end 
