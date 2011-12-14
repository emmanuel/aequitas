# -*- encoding: utf-8 -*-

require 'bigdecimal'
require 'bigdecimal/util'
require 'aequitas/rule'

module Aequitas
  class Rule
    class Magnitude < Rule

      equalize_on *superclass.equalizer.keys + [:expected]

      # TODO: move options normalization into the validator macros?
      def self.rules_for(attribute_name, options)
        options = options.dup

        eq  = scour_options_of_keys(options, [:eq,  :equal, :equals, :exactly, :equal_to])
        ne  = scour_options_of_keys(options, [:ne,  :not_equal_to])
        gt  = scour_options_of_keys(options, [:gt,  :greater_than])
        lt  = scour_options_of_keys(options, [:lt,  :less_than])
        gte = scour_options_of_keys(options, [:gte, :greater_than_or_equal_to])
        lte = scour_options_of_keys(options, [:lte, :less_than_or_equal_to])

        rules = []
        rules << GreaterThan.new(attribute_name, options.merge(:expected => gt))         if gt
        rules << LessThan.new(attribute_name, options.merge(:expected => lt))            if lt
        rules << GreaterThanOrEqual.new(attribute_name, options.merge(:expected => gte)) if gte
        rules << LessThanOrEqual.new(attribute_name, options.merge(:expected => lte))    if lte
        rules << Equal.new(attribute_name, options.merge(:expected => eq))               if eq
        rules << NotEqual.new(attribute_name, options.merge(:expected => ne))            if ne
        rules
      end

      def self.scour_options_of_keys(options, keys)
        keys.map { |key| options.delete(key) }.compact.first
      end

      attr_reader :expected

      def initialize(attribute_name, options)
        super

        @expected = options[:expected]
      end

      def valid?(resource)
        # TODO: is it even possible for expected to be nil?
        #   if so, return a dummy validator when expected is nil
        return true if expected.nil?

        value = attribute_value(resource)

        skip?(value) || valid_magnitude?(value)
      end

    end # class Magnitude
  end # class Rule
end # module Aequitas

require 'aequitas/rule/magnitude/equal'
require 'aequitas/rule/magnitude/greater_than'
require 'aequitas/rule/magnitude/greater_than_or_equal'
require 'aequitas/rule/magnitude/less_than'
require 'aequitas/rule/magnitude/less_than_or_equal'
require 'aequitas/rule/magnitude/not_equal'
