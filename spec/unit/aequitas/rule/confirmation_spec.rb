require 'spec_helper'
require 'aequitas/rule/confirmation'

describe Aequitas::Rule::Confirmation do
  let(:rule) { Aequitas::Rule::Confirmation.new(attribute_name, options) }
  let(:attribute_name) { :foo }
  let(:options) { { } }

  describe '#initialize' do
    let(:skip_condition) { MiniTest::Mock.new }
    let(:options) { { :skip_condition => skip_condition } }

    before do
      skip_condition.expect(:default_to_allowing_nil!,   nil)
      skip_condition.expect(:default_to_allowing_blank!, nil)
    end

    it('calls #default_to_allowing_nil! on its skip_condition')   { rule }
    it('calls #default_to_allowing_blank! on its skip_condition') { rule }
  end

  describe 'violation_type' do
    subject { rule.violation_type }

    it('returns :confirmation') { assert_equal :confirmation, subject }
  end

end
