require_relative '../../../spec_helper'
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

      describe '#allow_nil!' do
        subject { SkipCondition.new }

        it 'returns the receiver' do
          assert_same subject, subject.allow_nil!
        end

        it 'configures the receiver to allow nil' do
          subject.allow_nil!
          assert_predicate subject, :allow_nil?
        end
      end

      describe '#allow_blank!' do
        subject { SkipCondition.new }

        it 'returns the receiver' do
          assert_same subject, subject.allow_blank!
        end

        it 'configures the receiver to allow blank' do
          subject.allow_blank!
          assert_predicate subject, :allow_blank?
        end
      end

      describe '#reject_nil!' do
        subject { SkipCondition.new }

        it 'returns the receiver' do
          assert_same subject, subject.reject_nil!
        end

        it 'configures the receiver to reject nil' do
          subject.reject_nil!
          refute_predicate subject, :allow_nil?
        end
      end

      describe '#reject_blank!' do
        subject { SkipCondition.new }

        it 'returns the receiver' do
          assert_same subject, subject.reject_blank!
        end

        it 'configures the receiver to reject blank' do
          subject.reject_blank!
          refute_predicate subject, :allow_blank?
        end
      end

      describe '#default_to_allowing_nil!' do
        subject { SkipCondition.new }

        it 'returns the receiver' do
          assert_same subject, subject.default_to_allowing_nil!
        end

        it 'configures the receiver to allow nil if not configured' do
          subject.default_to_allowing_nil!
          assert_predicate subject, :allow_nil?
        end

        it 'does not configure the receiver to allow nil if already configured' do
          subject.reject_nil!
          subject.default_to_allowing_nil!
          refute_predicate subject, :allow_nil?
        end
      end

      describe '#default_to_allowing_blank!' do
        subject { SkipCondition.new }

        it 'returns the receiver' do
          assert_same subject, subject.default_to_allowing_blank!
        end

        it 'configures the receiver to allow blank' do
          subject.default_to_allowing_blank!
          assert_predicate subject, :allow_blank?
        end

        it 'does not configure the receiver to allow blank if already configured' do
          subject.reject_blank!
          subject.default_to_allowing_blank!
          refute_predicate subject, :allow_blank?
        end
      end

    end
  end
end
