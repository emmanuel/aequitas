require_relative '../../../spec_helper'
require_relative '../../shared/rule/integration_spec'
require 'aequitas'

module Aequitas
  class Rule
    IntegrationSpec.describe Method do
      before { class_under_test.validates_with_method attribute_name }

      describe 'when method returns a truthy value' do
        let(:attribute_value) { true }

        it_should_be_a_valid_instance
      end

      describe 'when method returns a falsy value' do
        let(:attribute_value) { false }

        it_should_be_an_invalid_instance
      end
    end
  end # class Rule
end # module Aequitas
