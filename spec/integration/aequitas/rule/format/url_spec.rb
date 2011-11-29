require_relative '../../../../spec_helper'
require_relative '../../../shared/rule/integration_spec'
require 'aequitas'

module Aequitas
  class Rule
    module Format
      IntegrationSpec.describe Formats::Url do
        before do
          class_under_test.validates_format_of attribute_name, :as => :url
        end

        describe 'when validated attribute is a URL' do
          let(:attribute_value) { 'http://www.example.com' }

          it_should_be_a_valid_instance
        end

        describe 'when validated attribute is not a URL' do
          let(:attribute_value) { 'not a url' }

          it_should_be_an_invalid_instance
        end
      end
    end # module Format
  end # class Rule
end # module Aequitas
