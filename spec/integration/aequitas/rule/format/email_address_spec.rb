require_relative '../../../../spec_helper'
require_relative '../../../shared/rule/integration_spec'
require 'aequitas'

module Aequitas
  class Rule
    module Format
      IntegrationSpec.describe Formats::EmailAddress do
        before do
          class_under_test.validates_format_of attribute_name, :as => :email_address
        end

        describe 'when validated attribute is an email address' do
          let(:attribute_value) { 'address@example.com' }

          it_should_be_a_valid_instance
        end

        describe 'when validated attribute is not an email address' do
          let(:attribute_value) { 'not an email' }

          it_should_be_an_invalid_instance
        end
      end
    end # module Format
  end # class Rule
end # module Aequitas
