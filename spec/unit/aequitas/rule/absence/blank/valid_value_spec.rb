require 'spec_helper'
require 'aequitas/rule/absence/blank'

describe Aequitas::Rule::Absence::Blank, '#valid_value?' do
  subject { rule.valid_value?(value) }

  let(:rule) { Aequitas::Rule::Absence::Blank.new(attribute_name, options) }
  let(:attribute_name) { :foo }
  let(:options) { Hash.new }

  describe 'when testing a non-empty string' do
    let(:value) { 'a' }

    it 'returns false' do
      refute subject, "expected false for #{value.inspect}"
    end
  end

  describe 'when testing a symbol' do
    let(:value) { :a }

    it 'returns false' do
      refute subject, "expected false for #{value.inspect}"
    end
  end

  describe 'when testing an empty string' do
    let(:value) { '' }

    it 'returns true' do
      assert subject, "expected false for #{value.inspect}"
    end
  end

  describe 'when testing false' do
    let(:value) { false }

    it 'returns true' do
      assert subject, "expected true for #{value.inspect}"
    end
  end

  describe 'when testing nil' do
    let(:value) { nil }

    it 'returns true' do
      assert subject, "expected true for #{value.inspect}"
    end
  end
end
