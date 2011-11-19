require 'spec_helper'
require 'aequitas/rule/acceptance'

module Aequitas
  class Rule
    describe Acceptance do
      subject { Acceptance.new(attribute_name, options) }
      let(:attribute_name) { :foo }
      let(:options) { Hash.new }

      describe '#initialize' do
        describe 'when the :accept option is present' do
          let(:options) { { accept: [:foo] } }

          it 'sets #accept to the provided value' do
            assert_equal [:foo], subject.accept
          end
        end

        describe 'when the :accept option is not present' do
          let(:options) { Hash.new }

          it 'sets #accept to the default accepted values' do
            assert_equal Acceptance::DEFAULT_ACCEPTED_VALUES, subject.accept
          end
        end

        describe 'when the :allow_nil option is absent' do
          it 'sets allow_nil? to true' do
            assert_predicate subject.skip_condition, :allow_nil?
          end
        end

        describe 'when the :allow_nil option is false' do
          let(:options) { { allow_nil: false } }

          it 'sets allow_nil? to false' do
            refute_predicate subject.skip_condition, :allow_nil?
          end
        end
      end

      describe '#valid?' do
        let(:resource) { MiniTest::Mock.new }
        let(:options) { { accept: ['a'] } }

        describe "when the target attribute's value is among the #accept values" do
          it 'returns true' do
            resource.expect(:validation_attribute_value, 'a', [attribute_name])
            assert_operator subject, :valid?, resource
          end
        end

        describe "when the target attribute's value is not among the #accept values" do
          it 'returns false' do
            resource.expect(:validation_attribute_value, 'b', [attribute_name])
            refute_operator subject, :valid?, resource
          end
        end
      end

      describe '#violation_type' do
        it 'returns :accepted' do
          resource = MiniTest::Mock.new
          assert_equal :accepted, subject.violation_type(resource)
        end
      end

    end
  end # class Rule
end # module Aequitas