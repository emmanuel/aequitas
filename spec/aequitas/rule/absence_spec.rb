require 'spec_helper'
require 'aequitas/rule/absence'

module Aequitas
  class Rule
    describe Absence do
      subject { Absence.new(attribute_name, options) }
      let(:attribute_name) { :foo }
      let(:options) { Hash.new }

      describe '#initialize' do
        describe 'when the :allow_nil option is true' do
          let(:options) { { allow_nil: true } }

          it 'sets allow_nil? to false' do
            refute_predicate subject.skip_condition, :allow_nil?
          end
        end

        describe 'when the :allow_blank option is true' do
          let(:options) { { allow_blank: true } }

          it 'sets allow_blank? to false' do
            refute_predicate subject.skip_condition, :allow_blank?
          end
        end
      end

      describe 'valid?' do
        let(:resource) { MiniTest::Mock.new }

        it "is false if the target's attribute is a non-empty string" do
          resource.expect(:validation_attribute_value, 'a', [attribute_name])
          refute_operator subject, :valid?, resource
        end

        it "is false if the target's attribute is a symbol" do
          resource.expect(:validation_attribute_value, :a, [attribute_name])
          refute_operator subject, :valid?, resource
        end

        it "is true if the target's attribute is an empty string" do
          resource.expect(:validation_attribute_value, '', [attribute_name])
          assert_operator subject, :valid?, resource
        end

        it "is true if the target's attribute is false" do
          resource.expect(:validation_attribute_value, false, [attribute_name])
          assert_operator subject, :valid?, resource
        end

        it "is true if the target's attribute is nil" do
          resource.expect(:validation_attribute_value, nil, [attribute_name])
          assert_operator subject, :valid?, resource
        end
      end

      describe '#violation_type' do
        it 'returns :absent' do
          resource = MiniTest::Mock.new
          assert_equal :absent, subject.violation_type(resource)
        end
      end

    end
  end
end
