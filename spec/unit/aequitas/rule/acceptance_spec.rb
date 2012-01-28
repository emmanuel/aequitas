require_relative '../../../spec_helper'
require 'aequitas/rule/acceptance'

describe Aequitas::Rule::Acceptance do
  let(:rule) { Aequitas::Rule::Acceptance.new(attribute_name, options) }
  let(:attribute_name) { :foo }
  let(:options) { Hash.new }

  describe '#initialize' do
    subject { rule }

    describe 'when the :accept option is present' do
      let(:options) { { accept: [:foo] } }

      it 'sets #accept to the provided value as a Set' do
        assert_equal [:foo].to_set, subject.accept
      end
    end

    describe 'when the :accept option is not present' do
      let(:options) { Hash.new }

      it 'sets #accept to the default accepted values' do
        assert_equal [ '1', 1, 'true', true, 't' ].to_set, subject.accept
      end
    end

    describe 'when the :allow_nil option is absent' do
      it 'sets allow_nil? to true' do
        assert_predicate subject.skip_condition, :allow_nil?
      end
    end

    describe 'when the :allow_nil option is false' do
      let(:options) { { allow_nil: false } }

      it 'sets allow_nil? to false' do
        refute_predicate subject.skip_condition, :allow_nil?
      end
    end
  end

  describe '#valid_value?' do
    subject { rule.valid_value?(value) }

    let(:options) { { accept: ['a'] } }

    describe "when testing a value that is among the #accept values" do
      let(:value) { 'a' }

      it('returns true') { assert subject, "expected true for #{value.inspect}" }
    end

    describe "when testing a value that is not among the #accept values" do
      let(:value) { 'b' }

      it('returns false') { refute subject, "expected false for #{value.inspect}" }
    end
  end

  describe '#violation_type' do
    subject { rule.violation_type }

    it('returns :accepted') { assert_equal :accepted, subject }
  end

end
