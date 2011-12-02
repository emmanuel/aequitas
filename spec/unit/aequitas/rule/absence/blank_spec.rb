require_relative '../../../../spec_helper'
require 'aequitas/rule/absence/blank'

describe Aequitas::Rule::Absence::Blank do
  subject { Aequitas::Rule::Absence::Blank.new(attribute_name, options) }
  let(:attribute_name) { :foo }
  let(:options) { Hash.new }

  describe '#valid?' do
    let(:resource) { MiniTest::Mock.new }

    it "is false if the target's attribute is a non-empty string" do
      resource.expect(:validation_attribute_value, 'a', [attribute_name])
      refute_operator subject, :valid?, resource
    end

    it "is false if the target's attribute is a symbol" do
      resource.expect(:validation_attribute_value, :a, [attribute_name])
      refute_operator subject, :valid?, resource
    end

    it "is true if the target's attribute is an empty string" do
      resource.expect(:validation_attribute_value, '', [attribute_name])
      assert_operator subject, :valid?, resource
    end

    it "is true if the target's attribute is false" do
      resource.expect(:validation_attribute_value, false, [attribute_name])
      assert_operator subject, :valid?, resource
    end

    it "is true if the target's attribute is nil" do
      resource.expect(:validation_attribute_value, nil, [attribute_name])
      assert_operator subject, :valid?, resource
    end
  end

  describe '#violation_type' do
    it 'returns :absent' do
      resource = MiniTest::Mock.new
      assert_equal :not_blank, subject.violation_type(resource)
    end
  end

end
