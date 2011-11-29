require_relative '../../../spec_helper'
require_relative '../../shared/rule/integration_spec'
require 'aequitas'

module Aequitas
  class Rule
    IntegrationSpec.describe Absence do
      before { class_under_test.validates_absence_of attribute_name }

      describe 'when validated attribute is present' do
        let(:attribute_value) { :foo }

        it_should_be_an_invalid_instance
      end

      describe 'when validated attribute is absent' do
        let(:attribute_value) { nil }

        it_should_be_a_valid_instance
      end
    end
  end # class Rule
end # module Aequitas
