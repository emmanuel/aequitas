require 'spec_helper'
require 'aequitas/rule/guard'

module Aequitas
  class Rule
    describe Guard do
      describe '#initialize' do
        it 'stores the :if option as #if_test' do
          expected = 'foo'
          assert_same expected, Guard.new(:if => expected).if_test
        end

        it 'stores the :unless option as #unless_test' do
          expected = 'foo'
          assert_same expected, Guard.new(:unless => expected).unless_test
        end
      end

      describe '#allow?' do
        let(:rule_guard) { Guard.new(:if => if_test, :unless => unless_test) }
        let(:if_test) { nil }
        let(:unless_test) { nil }

        describe 'when #if_test is present' do
          let(:if_test) { MiniTest::Mock.new }

          describe 'and #if_test responds to #call' do
            it 'invokes #call on the #if_test' do
              if_test.expect(:call, nil, [Object])
              rule_guard.allow?(Object.new)
            end
          end

          describe 'and #if_test is a Symbol' do
            let(:if_test) { :foo }

            it 'invokes the message identified by #if_test on the argument' do
              arg = MiniTest::Mock.new
              arg.expect(:foo, nil)
              rule_guard.allow?(arg)
            end
          end

          describe 'and evaluating #if_test results in a truthy value' do
            it 'returns true' do
              if_test.expect(:call, Object.new, [Object])
              assert_operator rule_guard, :allow?, Object.new
            end
          end

          describe 'and evaluating #if_test results in a falsy value' do
            it 'returns false' do
              if_test.expect(:call, nil, [Object])
              refute_operator rule_guard, :allow?, Object.new
            end
          end
        end

        describe 'when #unless_test is present' do
          let(:unless_test) { MiniTest::Mock.new }

          describe 'and #unless_test responds to #call' do
            it 'invokes #call on the clause' do
              unless_test.expect(:call, nil, [Object])
              rule_guard.allow?(Object.new)
            end
          end

          describe 'and #unless_test is a Symbol' do
            let(:unless_test) { :foo }

            it 'invokes the message identified by #unless_test on the argument' do
              arg = MiniTest::Mock.new
              arg.expect(:foo, nil)
              rule_guard.allow?(arg)
            end
          end

          describe 'and evaluating #unless_test results in a truthy value' do
            it 'returns false' do
              unless_test.expect(:call, Object.new, [Object])
              refute_operator rule_guard, :allow?, Object.new
            end
          end

          describe 'and evaluating #unless_test results in a falsy value' do
            it 'returns true if #call returns something falsy' do
              unless_test.expect(:call, nil, [Object])
              assert_operator rule_guard, :allow?, Object.new
            end
          end
        end

        describe 'when both #if_test and #unless_test are present' do
          let(:if_test)     { MiniTest::Mock.new }
          let(:unless_test) { MiniTest::Mock.new }

          describe 'and #if_test responds to #call' do
            it 'invokes #call on #if_test and ignores #unless_test' do
              arg = MiniTest::Mock.new
              if_test.expect(:call, nil, [Object])
              rule_guard.allow?(arg)
            end
          end

          describe 'and #if_test is a Symbol' do
            let(:if_test) { :foo }

            it 'invokes the message identified by #if_test on the argument and ignores #unless_test' do
              arg = MiniTest::Mock.new
              arg.expect(:foo, nil)
              rule_guard.allow?(arg)
            end
          end
        end

      end
    end
  end
end
