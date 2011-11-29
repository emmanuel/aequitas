require_relative '../../../spec_helper'
require 'aequitas/support/blank'

module Aequitas
  describe '.blank?' do
    it 'returns true when testing nil' do
      assert_operator Aequitas, :blank?, nil
    end

    it 'returns true when testing false' do
      assert_operator Aequitas, :blank?, false
    end

    it 'returns false when testing a Numeric' do
      refute_operator Aequitas, :blank?, 1
    end

    it 'returns false when testing true' do
      refute_operator Aequitas, :blank?, true
    end

    it 'returns true when testing an empty Hash' do
      assert_operator Aequitas, :blank?, {}
    end

    it 'returns true when testing an empty Array' do
      assert_operator Aequitas, :blank?, []
    end

    it 'returns false when testing an non-empty Hash' do
      refute_operator Aequitas, :blank?, { foo: :bar }
    end

    it 'returns false when testing an non-empty Array' do
      refute_operator Aequitas, :blank?, [:foo]
    end

    it 'returns true when testing an empty String' do
      assert_operator Aequitas, :blank?, ''
    end

    it 'returns true when testing a String with only whitespace' do
      assert_operator Aequitas, :blank?, "\n"
    end

    it 'returns false when testing a non-empty String' do
      refute_operator Aequitas, :blank?, 'target'
    end

    it 'returns true when #nil? is true for the argument' do
      target = MiniTest::Mock.new
      target.expect(:nil?, true)
      assert_operator Aequitas, :blank?, target
    end

    it 'returns false when #nil? is false for the argument' do
      target = MiniTest::Mock.new
      target.expect(:nil?, false)
      refute_operator Aequitas, :blank?, target
    end

    it 'returns false when #nil? is false and the argument does not respond to #empty?' do
      target = MiniTest::Mock.new
      target.expect(:nil?, false)
      refute_operator Aequitas, :blank?, target
    end

    it 'returns false when #nil? is false and the argument is not empty' do
      target = MiniTest::Mock.new
      target.expect(:nil?, false)
      target.expect(:empty?, false)
      refute_operator Aequitas, :blank?, target
    end

    it 'returns true when #nil? is false and the argument is empty' do
      target = MiniTest::Mock.new
      target.expect(:nil?, false)
      target.expect(:empty?, true)
      assert_operator Aequitas, :blank?, target
    end

  end
end
