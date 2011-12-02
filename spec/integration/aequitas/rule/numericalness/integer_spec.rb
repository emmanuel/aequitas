require_relative '../../../../spec_helper'
require_relative '../../../shared/rule/integration_spec'
require 'aequitas'

module Aequitas
  class Rule
    module Numericalness
      IntegrationSpec.describe Integer do
        before do
          class_under_test.validates_numericalness_of attribute_name, :only_integer => true
        end

        describe 'when validated attribute is an integer' do
          let(:attribute_value) { 1 }

          it_should_be_a_valid_instance
        end

        describe 'when validated attribute is not an integer' do
          let(:attribute_value) { 'a' }

          it_should_be_an_invalid_instance
        end
      end
    end # module Length
  end # class Rule
end # module Aequitas
