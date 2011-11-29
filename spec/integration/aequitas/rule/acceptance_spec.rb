require_relative '../../../spec_helper'
require_relative '../../shared/rule/integration_spec'
require 'aequitas'

module Aequitas
  class Rule
    IntegrationSpec.describe Acceptance do
      before { class_under_test.validates_acceptance_of attribute_name }

      describe 'when attribute value is accepted' do
        let(:attribute_value) { true }

        it_should_be_a_valid_instance
      end

      describe 'when attribute value is not accepted' do
        let(:attribute_value) { false }

        it_should_be_an_invalid_instance
      end
    end
  end # class Rule
end # module Aequitas
