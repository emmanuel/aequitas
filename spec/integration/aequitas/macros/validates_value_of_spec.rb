require 'spec_helper'
require 'shared/macros/integration_spec'
require 'aequitas'

Aequitas::Macros::IntegrationSpec.describe Aequitas::Macros, '#validates_value_of' do
  require 'date'

  describe 'with a lambda that returns lower and upper bounds' do
    before do
      class_under_test.validates_value_of attribute_name, :in => bound
    end

    let(:bound) { lambda { (Date.today - 5)..Date.today } }

    describe 'when validated attribute value is within the range' do
      let(:attribute_value) { bound.call.begin + 1 }

      it_should_be_a_valid_instance
    end

    describe 'when validated attribute value is not within the range' do
      let(:attribute_value) { bound.call.end + 1 }

      it_should_be_an_invalid_instance
    end
  end
end
