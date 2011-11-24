require_relative '../../../spec_helper'
require 'aequitas/rule/confirmation'

module Aequitas
  class Rule
    describe Confirmation do
      subject { Confirmation.new(attribute_name, options) }
      let(:attribute_name) { :foo }
      let(:options) { {} }

      describe '#initialize' do
        it 'calls #default_to_allowing_nil! on its skip_condition' do
          skip_condition = MiniTest::Mock.new
          skip_condition.expect(:default_to_allowing_nil!,   nil)
          skip_condition.expect(:default_to_allowing_blank!, nil)
          Confirmation.new(:foo, skip_condition: skip_condition)
        end

        it 'calls #default_to_allowing_blank! on its skip_condition' do
          skip_condition = MiniTest::Mock.new
          skip_condition.expect(:default_to_allowing_nil!,   nil)
          skip_condition.expect(:default_to_allowing_blank!, nil)
          Confirmation.new(:foo, skip_condition: skip_condition)
        end
      end

      describe '#valid?' do
        let(:resource) { MiniTest::Mock.new }
        let(:options) { { skip_condition: MiniTest::Mock.new } }
        let(:attribute_value) { :bar }

        before do
          resource.expect(:validation_attribute_value, attribute_value, [attribute_name])
          options[:skip_condition].expect(:default_to_allowing_nil!, nil)
          options[:skip_condition].expect(:default_to_allowing_blank!, nil)
        end

        describe 'when #skip? returns true' do
          before { options[:skip_condition].expect(:skip?, true, [attribute_value]) }

          it 'returns true' do

            assert_operator subject, :valid?, resource
          end
        end

        describe 'when #skip? returns false' do
          describe 'and the value equals the confirmation value' do
            before do
              options[:skip_condition].expect(:skip?, false, [attribute_value])
              resource.expect(:instance_variable_get, attribute_value, ["@#{attribute_name}_confirmation"])
            end

            it 'returns true' do
              assert_operator subject, :valid?, resource
            end
          end

          describe 'and the value does not equal the confirmation value' do
            before do
              options[:skip_condition].expect(:skip?, false, [attribute_value])
              resource.expect(:instance_variable_get, "#{attribute_value}asdf", ["@#{attribute_name}_confirmation"])
            end

            it 'returns false' do
              refute_operator subject, :valid?, resource
            end
          end
        end
      end

      describe 'violation_type' do
        it 'returns :confirmation' do
          assert_equal :confirmation, subject.violation_type(MiniTest::Mock.new)
        end
      end

    end
  end # class Rule
end # module Aequitas
