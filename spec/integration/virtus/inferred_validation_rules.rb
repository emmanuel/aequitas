require_relative '../../spec_helper'
require 'virtus'
require 'aequitas'
require 'aequitas/virtus'

describe Aequitas::Virtus::ClassMethodOverrides do
  let(:class_under_test) do
    class ClassUnderTest
      include Virtus
      include Aequitas

      attribute :boolean_with_presence, Boolean,  :required => true
      attribute :string_with_presence,  String,   :required => true
      attribute :string_with_length,    String,   :length   => 6..15
      attribute :string_with_format,    String,   :format   => /\w+@\w+\.com/

      self
    end
  end

  describe '.validation_rules' do
    it 'includes a Rule::Presence::NotNil for :boolean_with_presence' do
      skip 'not yet implemented'

      attribute_rules = class_under_test.validation_rules[:boolean_with_presence]
      rules = attribute_rules.select { |r| r.instance_of?(Aequitas::Rule::Presence::NotNil) }
      refute_predicate rules, :empty?
    end
  end

  describe '#string_with_presence' do
    subject { class_under_test.new(:string_with_presence => attribute_value) }

    describe 'when blank' do
      let(:attribute_value) { '' }

      it 'is not valid' do
        skip 'not yet implemented'

        refute_predicate subject, :valid?
      end
    end
  end
end
