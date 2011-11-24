require_relative '../../spec_helper'
require 'aequitas/rule/skip_condition'

module Aequitas
  class Rule
    describe SkipCondition do
      subject { SkipCondition.new(options) }

      describe '#initialize' do
        describe 'when :allow_nil is included and false' do
          let(:options) { { allow_nil: false } }
          
        end
        
      end

      describe '#skip?' do
        it 'is false when :allow_nil is absent and the value is nil' do
          refute_operator SkipCondition.new, :skip?, nil
        end

        it 'is false when :allow_nil is absent and the value is not nil' do
          refute_operator SkipCondition.new, :skip?, :foo
        end

        it 'is true when :allow_nil is true and the value is nil' do
          assert_operator SkipCondition.new(allow_nil: true), :skip?, nil
        end

        it 'is false when :allow_nil is true and the value is non-nil' do
          refute_operator SkipCondition.new(allow_nil: true), :skip?, :foo
        end

        it 'is false when :allow_nil is false and the value is nil' do
          refute_operator SkipCondition.new(allow_nil: false), :skip?, nil
        end

        it 'is false when :allow_nil is false and the value is non-nil' do
          refute_operator SkipCondition.new(allow_nil: false), :skip?, :foo
        end

        it 'is true when :allow_blank is true and the value is nil' do
          assert_operator SkipCondition.new(allow_blank: true), :skip?, nil
        end

        it 'is false when :allow_blank is true and the value is non-nil' do
          refute_operator SkipCondition.new(allow_blank: true), :skip?, :foo
        end
      end

      describe '#allow_nil?' do
        it 'is false when :allow_nil option is absent' do
          refute_predicate SkipCondition.new, :allow_nil?
        end

        it 'is false when :allow_nil option is false' do
          refute_predicate SkipCondition.new(allow_nil: false), :allow_nil?
        end

        it 'is true when :allow_nil option is true' do
          assert_predicate SkipCondition.new(allow_nil: true), :allow_nil?
        end
      end

      describe '#allow_blank?' do
        it 'is false when :allow_blank option is absent' do
          refute_predicate SkipCondition.new, :allow_blank?
        end

        it 'is false when :allow_blank option is false' do
          refute_predicate SkipCondition.new(allow_blank: false), :allow_blank?
        end

        it 'is true when :allow_blank option is true' do
          assert_predicate SkipCondition.new(allow_blank: true), :allow_blank?
        end
      end

    end
  end
end
