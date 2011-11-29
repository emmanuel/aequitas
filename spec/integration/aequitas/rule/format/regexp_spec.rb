require_relative '../../../../spec_helper'
require_relative '../../../shared/rule/integration_spec'
require 'aequitas'

module Aequitas
  class Rule
    module Format
      IntegrationSpec.describe Regexp do
        before do
          class_under_test.validates_format_of attribute_name, :with => /foo/
        end

        describe 'when validated attribute is present' do
          let(:attribute_value) { 'foo' }

          it_should_be_a_valid_instance
        end

        describe 'when validated attribute is absent' do
          let(:attribute_value) { 'bar' }

          it_should_be_an_invalid_instance
        end
      end
    end # module Format
  end # class Rule
end # module Aequitas
