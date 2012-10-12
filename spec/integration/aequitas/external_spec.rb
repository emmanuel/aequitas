require 'spec_helper'

describe Aequitas::Validator do

  let(:object) do
    mock = MiniTest::Mock.new
    mock.expect :name, name
    mock.expect :amount, amount
    mock
  end

  let(:class_under_test) do
    Class.new do
      include Aequitas::Validator

      validates_presence_of      :name
      validates_numericalness_of :amount
    end
  end

  subject { class_under_test.new(object) }

  describe 'valid attributes' do
    let(:name)   { 'John Doe' }
    let(:amount) { 815        }

    it '#valid? returns true' do
      assert_predicate subject, :valid?
    end

    it '#violations is empty' do
      assert_predicate subject.violations, :empty?
    end

    it 'violations on attributes are empty' do
      assert_predicate subject.violations.on(:name), :empty?
      assert_predicate subject.violations.on(:amount), :empty?
    end
  end

  describe 'invalid attributes' do
    let(:name)   { ''   }
    let(:amount) { 815  }

    it '#valid? returns false' do
      refute_predicate subject, :valid?
    end

    it 'violations on invalid attributes are not empty' do
      assert_equal subject.violations.on(:name).first.message, 'name must not be blank' 
    end

    it 'violations on valid attributes are empty' do
      assert_predicate subject.violations.on(:amount), :empty?
    end
  end
end
