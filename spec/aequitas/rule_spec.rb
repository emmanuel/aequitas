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
        assert_same attribute_name, Rule.new(attribute_name).attribute_name
      end

      it 'sets #custom_message to the :message option' do
        message = 'foo'
        assert_same message, Rule.new(:bar, message: message).custom_message
      end

      it 'initializes #guard with the :if and :unless options' do
        expected_guard = Rule::Guard.new(if: :a, unless: :b)
        assert_equal expected_guard, Rule.new(:bar, if: :a, unless: :b).guard
      end
    end

    describe '#execute?' do
      
    end

    describe '#allow_nil?' do
      it 'is false when :allow_nil option is absent' do
        refute_predicate Rule.new(:foo), :allow_nil?
      end

      it 'is false when :allow_nil option is false' do
        refute_predicate Rule.new(:foo, allow_nil: false), :allow_nil?
      end

      it 'is true when :allow_nil option is true' do
        assert_predicate Rule.new(:foo, allow_nil: true), :allow_nil?
      end
    end

    describe '#allow_blank?' do
      it 'is false when :allow_blank option is absent' do
        refute_predicate Rule.new(:foo), :allow_blank?
      end

      it 'is false when :allow_blank option is false' do
        refute_predicate Rule.new(:foo, allow_blank: false), :allow_blank?
      end

      it 'is true when :allow_blank option is true' do
        assert_predicate Rule.new(:foo, allow_blank: true), :allow_blank?
      end
    end

    describe '#skip?' do
      it 'is false when allow_nil is absent and the value is nil' do
        refute_operator Rule.new(:foo), :skip?, nil
      end

      it 'is false when allow_nil is absent and the value is non-nil' do
        refute_operator Rule.new(:foo), :skip?, :foo
      end

      it 'is true when allow_nil is true and the value is nil' do
        assert_operator Rule.new(:foo, allow_nil: true), :skip?, nil
      end

      it 'is false when allow_nil is true and the value is non-nil' do
        refute_operator Rule.new(:foo, allow_nil: true), :skip?, :foo
      end

      it 'is false when allow_nil is false and the value is nil' do
        refute_operator Rule.new(:foo, allow_nil: false), :skip?, nil
      end

      it 'is false when allow_nil is false and the value is non-nil' do
        refute_operator Rule.new(:foo, allow_nil: false), :skip?, :foo
      end

      it 'is true when allow_blank is true and the value is nil' do
        assert_operator Rule.new(:foo, allow_blank: true), :skip?, nil
      end

      it 'is false when allow_blank is true and the value is non-nil' do
        refute_operator Rule.new(:foo, allow_blank: true), :skip?, :foo
      end
    end
  end
end
