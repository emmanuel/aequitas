require_relative '../../../spec_helper'
require_relative '../../shared/rule/integration_spec'
require 'aequitas'

Aequitas::Rule::IntegrationSpec.describe Aequitas::Rule::Block do
  before do
    block_value = self.block_value
    class_under_test.validates_with_block(attribute_name) { block_value }
  end
  let(:attribute_value) { MiniTest::Mock.new }

  describe 'when block returns a truthy value' do
    let(:block_value) { true }

    it_should_be_a_valid_instance
  end

  describe 'when block returns a falsy value' do
    let(:block_value) { false }

    it_should_be_an_invalid_instance
  end
end
