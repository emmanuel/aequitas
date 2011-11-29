require_relative '../../../../spec_helper'
require 'aequitas/support/equalizable'

module Aequitas
  describe Equalizable::Equalizer do
    let(:equalizer) { Equalizable::Equalizer.new(keys) }
    let(:keys) { [:a, :b, :c] }

    describe '#initialize' do
      it "doesn't raise" do
        assert_kind_of Equalizable::Equalizer, equalizer
      end
    end

    describe '#keys' do
      it 'returns the values that the Equalizer was initialized with' do
        assert_equal [:a, :b, :c], equalizer.keys
      end
    end
  end
end
