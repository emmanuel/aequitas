require 'spec_helper'
require 'aequitas/rule'

module Aequitas
  describe Rule do
    let(:rule) { Rule.new(attribute_name, options) }
    let(:attribute_name) { :foo }
    let(:options) { Hash.new }

    describe '#initialize' do
      it 'sets #attribute_name to the first arg' do
        attribute_name = :foo
        assert_same attribute_name, Rule::Length.new(attribute_name, :length => 10).attribute_name
      end

      it 'sets #custom_message to the :message option' do
        message = 'foo'
        assert_same message, Rule::Length.new(:bar, :length => 10, :message => message).custom_message
      end

      it 'initializes #guard with the :if and :unless options' do
        expected_guard = Rule::Guard.new(:if => :a, :unless => :b)
        assert_equal expected_guard, Rule::Length.new(:bar, :length => 10, :if => :a, :unless => :b).guard
      end
    end

    describe '#validate' do
      
    end

    describe '#execute?' do
      
    end

    describe '#skip?' do
      
    end

  end
end
