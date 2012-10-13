require 'spec_helper'
require 'aequitas/violation_set'

module Aequitas
  describe ViolationSet do
    let(:object) { Object.new }
    let(:arguments) { [] }
    let(:violation_set) { ViolationSet.new(*arguments) }
    let(:violation_1) { Violation::Message.new(object, 'message 1', :attribute_name => :attribute) }
    let(:violation_2) { Violation::Message.new(object, 'message 2', :attribute_name => :attribute) }
    let(:violation_3) { Violation::Message.new(object, 'message 2', :attribute_name => :other) }

    describe '#initialize' do
      it 'does not raise any errors' do
        # TODO: implement JUnit-style #assert_that and matchers:
        # assert_that violation_set, is(:kind_of?, ViolationSet)
        assert_kind_of ViolationSet, violation_set
      end
    end

    describe '#on' do

      it 'returns nil when no error is present on the requested attribute' do
        assert_predicate violation_set.on(:foo), :empty?
      end

      describe 'when violation on attribute is present' do
        let(:arguments) { [[violation_1]] }

        it 'returns the violation' do
          assert_equal [violation_1], violation_set.on(:attribute)
        end
      end

      describe 'when multiple violations are present' do
        let(:arguments) { [[violation_1, violation_2]] }

        it 'returns the violations via #on in the order they were added' do
          assert_equal [violation_1, violation_2], violation_set.on(:attribute)
        end
      end

      describe 'when duplicate violations are used to construct the set' do
        let(:arguments) { [[violation_1, violation_2, violation_3]] }

        it 'returns the violations via #on deduplicated' do
          assert_equal [violation_1, violation_2], violation_set.on(:attribute)
        end
      end
    end

    describe '#empty?' do
      describe 'when initialized without violations' do
        it 'is true' do
          assert_predicate violation_set, :empty?
        end
      end

      describe 'when initialized with violations' do
        let(:arguments) { [[violation_1]] }
       
        it 'is false' do
          violation_set.on(:attribute)
          refute_predicate violation_set, :empty?
        end
      end
    end

    describe '#each' do
      let(:arguments) { [[violation_1, violation_2, violation_3]] }

      it 'iterates over properties and yields error message arrays' do
        expected = [[violation_1, violation_2], [violation_3]]
        assert_equal expected, violation_set.inject([]) { |mem, var| mem << var }
      end
    end
  end
end
