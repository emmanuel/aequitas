require_relative '../../../spec_helper'
require 'aequitas'

module Aequitas
  class Rule
    class PresenceSpec < IntegrationSpec
      describe Presence do
        before { class_under_test.validates_presence_of attribute_name }

        describe 'when validated attribute is present' do
          let(:attribute_value) { :foo }

          it_should_be_a_valid_instance
        end

        describe 'when validated attribute is absent' do
          let(:attribute_value) { nil }

          it_should_be_an_invalid_instance
        end
      end
    end # class AbsenceSpec
  end # class Rule
end # module Aequitas
