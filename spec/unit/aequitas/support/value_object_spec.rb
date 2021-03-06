require 'spec_helper'
require 'aequitas/support/value_object'

module Aequitas
  describe ValueObject do
    let(:value_object_test_class) do
      Class.new do
        extend ValueObject

        equalize_on :foo, :bar

        attr_reader :foo, :bar, :baz

        def initialize(foo, bar, baz)
          @foo, @bar, @baz = foo, bar, baz
        end
      end
    end

    describe '.equalizer' do
      it 'returns the Equalizer module for the class' do
        assert_instance_of ValueObject::Equalizer,
          value_object_test_class.equalizer
      end
    end

    describe '.equalizer.keys' do
      it 'returns the keys that the class is equalized on' do
        assert_equal [:foo, :bar], value_object_test_class.equalizer.keys
      end
    end

    describe 'when all equalized attributes are the same' do
      let(:first)  { value_object_test_class.new(:a, :b, :c) }
      let(:second) { value_object_test_class.new(:a, :b, :d) }

      describe '#eql?' do
        it 'returns true' do
          assert first.eql?(second), 'expected first.eql?(second) to be true'
        end
      end

      describe '#==' do
        it 'returns true' do
          assert_equal first, second
        end
      end
    end

    describe 'when an equalized attribute is different' do
      let(:first)  { value_object_test_class.new(:a, :b, :c) }
      let(:second) { value_object_test_class.new(:a, :c, :d) }

      describe '#eql?' do
        it 'returns false' do
          refute first.eql?(second), 'expected first.eql?(second) to be false'
        end
      end

      describe '#==' do
        it 'returns false' do
          refute_equal first, second
        end
      end
    end
  end
end
