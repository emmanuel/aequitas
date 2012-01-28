require_relative '../../../spec_helper'
require 'aequitas/class_methods'


describe Aequitas::ClassMethods, '#inherited' do
  subject { descendant_class }

  let(:base_class) { Class.new { extend Aequitas::ClassMethods } }
  let(:descendant_class) { Class.new(base_class) }

  let(:rule_class)       { Aequitas::Rule::Presence }
  let(:attribute_name)   { :foo }
  let(:expected_rule)    { rule_class.new(attribute_name) }

  it "copies the parent's existing validation rules to the descendant" do
    base_class.validation_rules.add(rule_class, [attribute_name])
    assert_includes subject.validation_rules[attribute_name], expected_rule
  end

  it "the descendant has access to validation rules added to the parent after inheritance" do
    skip 'implement inheritance references instead of statically copying (ala Virtus::AttributeSet)'
    assert_predicate descendant_class.validation_rules[:default], :empty?
    base_class.validation_rules.add(rule_class, [attribute_name])
    other_expected_rule = rule_class.new(attribute_name)
    assert_includes subject.validation_rules[attribute_name], other_expected_rule
  end

end
