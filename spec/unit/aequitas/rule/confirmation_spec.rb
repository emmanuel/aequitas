require_relative '../../../spec_helper'
require 'aequitas/rule/confirmation'

module Aequitas
  class Rule
    describe Confirmation do
      let(:rule) { Confirmation.new(attribute_name, options) }
      let(:attribute_name) { :foo }
      let(:options) { { } }
      let(:resource) { MiniTest::Mock.new }

      describe '#initialize' do
        let(:skip_condition) { MiniTest::Mock.new }
        let(:options) { { :skip_condition => skip_condition } }

        before do
          skip_condition.expect(:default_to_allowing_nil!,   nil)
          skip_condition.expect(:default_to_allowing_blank!, nil)
        end

        it('calls #default_to_allowing_nil! on its skip_condition')   { rule }
        it('calls #default_to_allowing_blank! on its skip_condition') { rule }
      end

      # def validate(resource)
      #   value = attribute_value(resource)
      # 
      #   if skip?(value) || value == confirmation_value(resource)
      #     nil
      #   else
      #     Violation::Rule.new(resource, custom_message, :rule => self)
      #   end
      # end
      describe '#validate' do
        subject { rule.validate(resource) }

        let(:options)         { { :skip_condition => skip_condition } }
        let(:skip_condition)  { MiniTest::Mock.new }
        let(:attribute_value) { :bar }

        before do
          resource.expect(:validation_attribute_value, attribute_value, [attribute_name])
          skip_condition.expect(:default_to_allowing_nil!,   nil)
          skip_condition.expect(:default_to_allowing_blank!, nil)
        end

        describe 'when #skip? returns true' do
          before { skip_condition.expect(:skip?, true, [attribute_value]) }

          it('returns nil') { assert_equal nil, subject }
        end

        describe 'when #skip? returns false' do
          before { skip_condition.expect(:skip?, false, [attribute_value]) }

          describe 'and the value equals the confirmation value' do
            before { resource.expect(:instance_variable_get, attribute_value, ["@#{rule.confirmation_attribute_name}"]) }

            it('returns nil') { assert_equal nil, subject }
          end

          describe 'and the value does not equal the confirmation value' do
            let(:expected_violation) { Violation::Rule.new(resource, nil, :rule => rule) }

            before do
              options[:skip_condition].expect(:skip?, false, [attribute_value])
              resource.expect(:instance_variable_get, "#{attribute_value}asdf", ["@#{attribute_name}_confirmation"])
              # Yuck... not sure how to handle this better
              #   Issue is that Violation#== compares resource with itself
              resource.expect(:==, true, [resource])
            end

            it('returns a Violation') { assert_equal expected_violation, subject }
          end
        end
      end

      describe 'violation_type' do
        subject { rule.violation_type(resource) }

        it('returns :confirmation') { assert_equal :confirmation, subject }
      end

    end
  end # class Rule
end # module Aequitas
