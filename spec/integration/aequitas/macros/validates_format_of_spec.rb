require 'spec_helper'
require 'shared/macros/integration_spec'
require 'aequitas'

Aequitas::Macros::IntegrationSpec.describe Aequitas::Macros, '#validates_format_of' do
  describe 'with a Proc' do
    before do
      class_under_test.validates_format_of attribute_name, :with => lambda { |value| value.valid? }
    end

    describe 'when format proc returns true' do
      let(:attribute_value) do
        val = MiniTest::Mock.new
        val.expect(:nil?, false)
        val.expect(:valid?, true)
        val
      end

      it_should_be_a_valid_instance
    end

    describe 'when validated attribute is absent' do
      let(:attribute_value) do
        val = MiniTest::Mock.new
        val.expect(:nil?, false)
        val.expect(:valid?, false)
        val
      end

      it_should_be_an_invalid_instance
    end
  end

  describe 'with a Regexp' do
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

  describe 'with :url' do
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

  describe 'with :email_address' do
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
end
