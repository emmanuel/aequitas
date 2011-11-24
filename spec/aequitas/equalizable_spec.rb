require_relative '../spec_helper'
require 'aequitas/equalizable'

module Aequitas
  describe Equalizable do
    let(:equalizable_test_class) do
      Class.new do
        extend Equalizable

        equalize_on [:foo, :bar]

        attr_reader :foo, :bar, :baz

        def initialize(foo, bar, baz)
          @foo, @bar, @baz = foo, bar, baz
        end
      end
    end

    describe '.equalizer' do
      it 'returns the Equalizer module for the class' do
        assert_instance_of Equalizable::Equalizer,
          equalizable_test_class.equalizer
      end
    end

    describe '.equalizer.keys' do
      it 'returns the keys that the class is equalized on' do
        assert_equal [:foo, :bar], equalizable_test_class.equalizer.keys
      end
    end

    describe 'when all equalized attributes are the same' do
      let(:first)  { equalizable_test_class.new(:a, :b, :c) }
      let(:second) { equalizable_test_class.new(:a, :b, :d) }

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
      let(:first)  { equalizable_test_class.new(:a, :b, :c) }
      let(:second) { equalizable_test_class.new(:a, :c, :d) }

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
