require_relative '../../../../spec_helper'
require 'aequitas/rule/confirmation'

describe Aequitas::Rule::Confirmation, '#validate' do
  subject { rule.validate(resource) }

  let(:rule) { Aequitas::Rule::Confirmation.new(attribute_name, options) }
  let(:attribute_name) { :foo }
  let(:options) { { } }

  let(:options)         { { :skip_condition => skip_condition } }
  let(:skip_condition)  { MiniTest::Mock.new }
  let(:resource)        { MiniTest::Mock.new }
  let(:attribute_value) { :bar }

  before do
    resource.expect(:validation_attribute_value, attribute_value, [attribute_name])
    skip_condition.expect(:default_to_allowing_nil!,   nil)
    skip_condition.expect(:default_to_allowing_blank!, nil)
  end

  describe 'when #skip? returns true' do
    before { skip_condition.expect(:skip?, true, [attribute_value]) }

    it('returns nil') { assert_equal nil, subject }
  end

  describe 'when #skip? returns false' do
    before { skip_condition.expect(:skip?, false, [attribute_value]) }

    describe 'and the value equals the confirmation value' do
      before { resource.expect(:instance_variable_get, attribute_value, ["@#{rule.confirmation_attribute_name}"]) }

      it('returns nil') { assert_equal nil, subject }
    end

    describe 'and the value does not equal the confirmation value' do
      let(:expected_violation) do
        Aequitas::Violation::Rule.new(resource, nil, :rule => rule)
      end

      before do
        options[:skip_condition].expect(:skip?, false, [attribute_value])
        resource.expect(:instance_variable_get,
                        "#{attribute_value}asdf",
                        ["@#{attribute_name}_confirmation"])
        # Yuck... not sure how to handle this better
        #   Issue is that Violation#== compares resource with itself
        resource.expect(:==, true, [resource])
      end

      it('returns a Violation') { assert_equal expected_violation, subject }
    end
  end
end
