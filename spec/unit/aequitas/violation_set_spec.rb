require_relative '../../spec_helper'
require 'aequitas/violation_set'

module Aequitas
  describe ViolationSet do
    let(:object) { Object.new }
    let(:violation_set) { ViolationSet.new(object) }

    describe '#initialize' do
      it 'does not raise any errors' do
        # TODO: implement JUnit-style #assert_that and matchers:
        # assert_that violation_set, is(:kind_of?, ViolationSet)
        assert_kind_of ViolationSet, violation_set
      end
    end

    describe '#on' do
      let(:violation) { Violation.new(object, 'message', nil, :attribute) }

      it 'returns nil when no error is present on the requested attribute' do
        assert_nil violation_set.on(:foo)
      end

      describe 'after adding a message via a symbol attribute name' do
        it 'returns the message that was added (as a Violation)' do
          violation_set.add(:attribute, 'message')

          assert_equal [violation], violation_set.on(:attribute)
        end
      end

      describe 'after adding a message via a string attribute name' do
        it 'returns the message that was added when accessed via symbol' do
          skip 'convert to handling attribute names as strings'
          violation_set.add('attribute', 'message')

          assert_equal [violation], violation_set.on('attribute')
          # assert_equal [violation], violation_set.on(:attribute)
        end
      end
    end

    describe '#add' do
      let(:violation_1) { Violation.new(object, 'message 1', nil, :attribute) }
      let(:violation_2) { Violation.new(object, 'message 2', nil, :attribute) }

      it 'returns the receiver' do
        # assert_that violation_set.add(:foo, 'message'), is(:equal?, violation_set)
        assert_same violation_set, violation_set.add(:foo, 'message')
      end

      describe 'after adding a single message' do
        it 'is is accessible via #on' do
          violation_set.add(violation_1.attribute_name, violation_1.custom_message)

          assert_equal [violation_1], violation_set.on(violation_1.attribute_name)
        end
      end

      describe 'after adding a single Violation' do
        it 'is is accessible via #on' do
          violation_set.add(violation_1)

          assert_equal [violation_1], violation_set.on(:attribute)
        end
      end

      describe 'after adding a second message' do
        it 'returns the violations via #on in the order they were added' do
          violation_set.add(violation_1.attribute_name, violation_1.custom_message)
          violation_set.add(violation_2.attribute_name, violation_2.custom_message)

          assert_equal [violation_1, violation_2], violation_set.on(:attribute)
        end
      end

      describe 'after adding the same message twice' do
        it 'returns a single instance of that message via #on' do
          violation_set.add(:attribute, 'message')
          violation_set.add(:attribute, 'message')

          assert_equal violation_set.on(:attribute), ['message']
        end
      end

      describe 'after adding a second Violation' do
        it 'returns the violations via #on in the order they were added' do
          violation_set.add(violation_1)
          violation_set.add(violation_2)

          assert_equal [violation_1, violation_2], violation_set.on(:attribute)
        end
      end

      describe 'after adding an equivalent Violation twice' do
        let(:violation_1) { Violation.new(object, 'message', nil, :attribute) }
        let(:violation_2) { Violation.new(object, 'message', nil, :attribute) }

        it 'returns a single instance of that message via #on' do
          violation_set.add(violation_1)
          violation_set.add(violation_2)

          assert_equal [violation_1], violation_set.on(:attribute)
        end
      end
    end

    describe '#empty?' do
      it 'is initially true' do
        # TODO: implement JUnit-style #assert_that and matchers
        # assert_that violation_set, is(:empty?)
        assert_predicate violation_set, :empty?
      end

      describe 'after calling #on' do
        it 'is true' do
          violation_set.on(:attribute)
          assert_predicate violation_set, :empty?
        end
      end

      describe 'after adding a message' do
        it 'is false' do
          violation_set.add(:attribute, 'message')
          refute_predicate violation_set, :empty?
        end
      end

      describe 'after adding a Violation' do
        let(:violation) { Violation.new(object, 'message', nil, :attribute) }

        it 'is false' do
          violation_set.add(violation)
          refute_predicate violation_set, :empty?
        end
      end
    end

    describe '#each' do
      let(:violation_1) { Violation.new(object, 'message 1', nil, :attribute) }
      let(:violation_2) { Violation.new(object, 'message 2', nil, :attribute) }
      let(:violation_3) { Violation.new(object, 'another message', nil, :foo) }

      it 'iterates over properties and yields error message arrays' do
        violation_set.add(violation_1)
        violation_set.add(violation_2)
        violation_set.add(violation_3)

        expected = [[violation_1, violation_2], [violation_3]]
        assert_equal expected, violation_set.inject([]) { |mem, var| mem << var }
      end
    end
  end
end
