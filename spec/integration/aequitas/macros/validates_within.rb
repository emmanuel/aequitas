require_relative '../../../spec_helper'
require_relative '../../shared/macros/integration_spec'
require 'aequitas'

Aequitas::Macros::IntegrationSpec.describe Aequitas::Macros, '#validates_within' do
  describe 'with Range option for :set' do
    describe 'with lower and upper bounds' do
      before do
        class_under_test.validates_within attribute_name, :set => set
      end

      let(:set) { 1..5 }

      describe 'when validated attribute value is within the range' do
        let(:attribute_value) { set.begin + 1 }

        it_should_be_a_valid_instance
      end

      describe 'when validated attribute value is not within the range' do
        let(:attribute_value) { set.end + 1 }

        it_should_be_an_invalid_instance
      end
    end

    describe 'with no lower bound' do
      before do
        class_under_test.validates_within attribute_name, :set => set
      end

      let(:set) { -(1.0/0)..5 }

      describe 'when validated attribute value is within the range' do
        let(:attribute_value) { set.end - 1 }

        it_should_be_a_valid_instance
      end

      describe 'when validated attribute value is not within the range' do
        let(:attribute_value) { set.end + 1 }

        it_should_be_an_invalid_instance
      end
    end

    describe 'with no upper bound' do
      before do
        class_under_test.validates_within attribute_name, :set => set
      end

      let(:set) { 1..(1.0/0) }

      describe 'when validated attribute value is within the range' do
        let(:attribute_value) { set.begin + 1 }

        it_should_be_a_valid_instance
      end

      describe 'when validated attribute value is not within the range' do
        let(:attribute_value) { set.begin - 1 }

        it_should_be_an_invalid_instance
      end
    end
  end

  describe 'with Set option for :set' do
    before do
      class_under_test.validates_within attribute_name, :set => Set[*set]
    end

    let(:set) { [:a, :b, :c] }

    describe 'when validated attribute value is included in the set' do
      let(:attribute_value) { set.first }

      it_should_be_a_valid_instance
    end

    describe 'when validated attribute value is not included in the set' do
      let(:attribute_value) { :foo }

      it_should_be_an_invalid_instance
    end
  end
end
