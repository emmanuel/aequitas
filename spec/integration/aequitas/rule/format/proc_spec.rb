require_relative '../../../../spec_helper'
require_relative '../../../shared/rule/integration_spec'
require 'aequitas'

module Aequitas
  class Rule
    module Format
      IntegrationSpec.describe Proc do
        before do
          class_under_test.validates_format_of attribute_name, :with => lambda { |value| value.valid? }
        end

        describe 'when format proc returns true' do
          let(:attribute_value) do
            val = MiniTest::Mock.new
            val.expect(:nil?, false)
            val.expect(:valid?, true)
            val
          end

          it_should_be_a_valid_instance
        end

        describe 'when validated attribute is absent' do
          let(:attribute_value) do
            val = MiniTest::Mock.new
            val.expect(:nil?, false)
            val.expect(:valid?, false)
            val
          end

          it_should_be_an_invalid_instance
        end
      end
    end # module Format
  end # class Rule
end # module Aequitas
