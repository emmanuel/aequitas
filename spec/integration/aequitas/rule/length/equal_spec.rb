require_relative '../../../../spec_helper'
require_relative '../../../shared/rule/integration_spec'
require 'aequitas'

module Aequitas
  class Rule
    module Length
      IntegrationSpec.describe Equal do
        before do
          class_under_test.validates_length_of attribute_name, :is => 3
        end

        describe 'when validated attribute value is expected length' do
          let(:attribute_value) { 'foo' }

          it_should_be_a_valid_instance
        end

        describe 'when validated attribute value is not expected length' do
          let(:attribute_value) { 'barz' }

          it_should_be_an_invalid_instance
        end
      end
    end # module Length
  end # class Rule
end # module Aequitas
