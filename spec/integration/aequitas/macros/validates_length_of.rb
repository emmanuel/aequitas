require_relative '../../../spec_helper'
require_relative '../../shared/macros/integration_spec'
require 'aequitas'

Aequitas::Macros::IntegrationSpec.describe Aequitas::Macros, '#validates_length_of' do
  describe 'with :is or :equal options' do
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

  describe 'with :max or :maximum options' do
    before do
      class_under_test.validates_length_of attribute_name, :max => 3
    end

    describe 'when validated attribute value is at most expected length' do
      let(:attribute_value) { 'foo' }

      it_should_be_a_valid_instance
    end

    describe 'when validated attribute value is more than expected length' do
      let(:attribute_value) { 'barz' }

      it_should_be_an_invalid_instance
    end
  end

  describe 'with :min or :minimum options' do
    before do
      class_under_test.validates_length_of attribute_name, :min => 3
    end

    describe 'when validated attribute value is at least expected length' do
      let(:attribute_value) { 'foo' }

      it_should_be_a_valid_instance
    end

    describe 'when validated attribute value is less than expected length' do
      let(:attribute_value) { 'bz' }

      it_should_be_an_invalid_instance
    end
  end

  describe 'with :in or :within options' do
    before do
      class_under_test.validates_length_of attribute_name, :in => 2..3
    end

    describe 'when validated attribute value length is within expected range' do
      let(:attribute_value) { 'foo' }

      it_should_be_a_valid_instance
    end

    describe 'when validated attribute value length is not within expected range' do
      let(:attribute_value) { 'barz' }

      it_should_be_an_invalid_instance
    end
  end
end
