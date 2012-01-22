require_relative '../../../../spec_helper'
require 'aequitas/rule/absence/blank'

describe Aequitas::Rule::Absence::Blank do
  let(:rule) { Aequitas::Rule::Absence::Blank.new(attribute_name, options) }
  let(:attribute_name) { :foo }
  let(:options) { Hash.new }

  describe '#valid_value?' do
    subject { rule.valid_value?(value) }

    describe 'when testing a non-empty string' do
      let(:value) { 'a' }

      it('returns false') { refute subject, "expected false for #{value.inspect}" }
    end

    describe 'when testing a symbol' do
      let(:value) { :a }

      it('returns false') { refute subject, "expected false for #{value.inspect}" }
    end

    describe 'when testing an empty string' do
      let(:value) { '' }

      it('returns true') { assert subject, "expected false for #{value.inspect}" }
    end

    describe 'when testing false' do
      let(:value) { false }

      it('returns true') { assert subject, "expected true for #{value.inspect}" }
    end

    describe 'when testing nil' do
      let(:value) { nil }

      it('returns true') { assert subject, "expected true for #{value.inspect}" }
    end
  end

  describe '#violation_type' do
    subject { rule.violation_type(resource) }

    let(:resource) { MiniTest::Mock.new }

    it('returns :absent') { assert_equal :not_blank, subject }
  end

end
