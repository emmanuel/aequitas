require 'spec_helper'
require 'aequitas/rule/acceptance'

describe Aequitas::Rule::Acceptance, '#valid_value?' do
  subject { rule.valid_value?(value) }

  let(:rule) { Aequitas::Rule::Acceptance.new(attribute_name, options) }
  let(:attribute_name) { :foo }
  let(:options) { Hash.new }

  let(:options) { { :accept => ['a'] } }

  describe "when testing a value that is among the #accept values" do
    let(:value) { 'a' }

    it('returns true') { assert subject, "expected true for #{value.inspect}" }
  end

  describe "when testing a value that is not among the #accept values" do
    let(:value) { 'b' }

    it('returns false') { refute subject, "expected false for #{value.inspect}" }
  end
end
