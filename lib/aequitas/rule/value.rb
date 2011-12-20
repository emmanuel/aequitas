# -*- encoding: utf-8 -*-

require 'bigdecimal'
require 'bigdecimal/util'
require 'aequitas/rule'

module Aequitas
  class Rule
    class Value < Rule

      equalize_on *superclass.equalizer.keys + [:expected]

      # TODO: move options normalization into the validator macros?
      def self.rules_for(attribute_name, options)
        eq  = options.values_at(:eq,  :equal, :equals, :equal_to, :exactly).compact.first
        ne  = options.values_at(:ne,  :not_equal_to).compact.first
        gt  = options.values_at(:gt,  :greater_than).compact.first
        lt  = options.values_at(:lt,  :less_than).compact.first
        gte = options.values_at(:gte, :greater_than_or_equal_to).compact.first
        lte = options.values_at(:lte, :less_than_or_equal_to).compact.first
        rng = options.values_at(:in,  :within).compact.first

        rules = []
        rules << Equal.new(attribute_name,              options.merge(:expected => eq))  if eq
        rules << NotEqual.new(attribute_name,           options.merge(:expected => ne))  if ne
        rules << GreaterThan.new(attribute_name,        options.merge(:expected => gt))  if gt
        rules << LessThan.new(attribute_name,           options.merge(:expected => lt))  if lt
        rules << GreaterThanOrEqual.new(attribute_name, options.merge(:expected => gte)) if gte
        rules << LessThanOrEqual.new(attribute_name,    options.merge(:expected => lte)) if lte
        rules << Range.new(attribute_name,              options.merge(:expected => rng)) if rng
        rules
      end

      def initialize(attribute_name, options)
        super

        @expected = options.fetch(:expected)
      end

      def expected
        @expected.respond_to?(:call) ? @expected.call : @expected
      end

      def valid?(resource)
        # TODO: is it even possible for expected to be nil?
        #   if so, return a dummy validator when expected is nil
        return true if expected.nil?

        value = attribute_value(resource)

        skip?(value) || valid_value?(value)
      end

    end # class Value
  end # class Rule
end # module Aequitas

require 'aequitas/rule/value/equal'
require 'aequitas/rule/value/greater_than'
require 'aequitas/rule/value/greater_than_or_equal'
require 'aequitas/rule/value/less_than'
require 'aequitas/rule/value/less_than_or_equal'
require 'aequitas/rule/value/not_equal'
require 'aequitas/rule/value/range'
