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

      it 'sets #if_clause to the :if option' do
        if_clause = :foo
        assert_same if_clause, Rule.new(:bar, if: if_clause).if_clause
      end

      it 'sets #unless_clause to the :unless option' do
        unless_clause = :foo
        assert_same unless_clause, Rule.new(:bar, unless: unless_clause).unless_clause
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

    describe '#optional?' do
      it 'is false when allow_nil is absent and the value is nil' do
        refute_operator Rule.new(:foo), :optional?, nil
      end

      it 'is false when allow_nil is absent and the value is non-nil' do
        refute_operator Rule.new(:foo), :optional?, :foo
      end

      it 'is true when allow_nil is true and the value is nil' do
        assert_operator Rule.new(:foo, allow_nil: true), :optional?, nil
      end

      it 'is false when allow_nil is true and the value is non-nil' do
        refute_operator Rule.new(:foo, allow_nil: true), :optional?, :foo
      end

      it 'is false when allow_nil is false and the value is nil' do
        refute_operator Rule.new(:foo, allow_nil: false), :optional?, nil
      end

      it 'is false when allow_nil is false and the value is non-nil' do
        refute_operator Rule.new(:foo, allow_nil: false), :optional?, :foo
      end

      it 'is true when allow_blank is true and the value is nil' do
        assert_operator Rule.new(:foo, allow_blank: true), :optional?, nil
      end

      it 'is false when allow_blank is true and the value is non-nil' do
        refute_operator Rule.new(:foo, allow_blank: true), :optional?, :foo
      end
    end
  end
end
