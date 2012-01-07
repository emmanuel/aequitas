require_relative '../../../../spec_helper'
require 'aequitas/support/value_object'

module Aequitas
  describe ValueObject::Equalizer do
    let(:equalizer) { ValueObject::Equalizer.new(keys) }
    let(:keys) { [:a, :b, :c] }

    describe '#initialize' do
      it "doesn't raise" do
        assert_kind_of ValueObject::Equalizer, equalizer
      end
    end

    describe '#keys' do
      it 'returns the values that the Equalizer was initialized with' do
        assert_equal [:a, :b, :c], equalizer.keys
      end
    end
  end
end
