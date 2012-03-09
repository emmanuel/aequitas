# -*- encoding: utf-8 -*-

require 'aequitas/rule'

module Aequitas
  class Rule
    class Length < Rule

      # TODO: move options normalization into the validator macros
      def self.rules_for(attribute_name, options)
        options = options.dup

        equal   = options.values_at(:is,  :equals).compact.first
        range   = options.values_at(:in,  :within).compact.first
        minimum = options.values_at(:min, :minimum).compact.first
        maximum = options.values_at(:max, :maximum).compact.first

        if minimum && maximum
          range ||= minimum..maximum
        end

        rule =
          if equal
            Length::Equal.new(attribute_name,   options.merge(:expected => equal))
          elsif range
            Length::Range.new(attribute_name,   options.merge(:range => range))
          elsif minimum
            Length::Minimum.new(attribute_name, options.merge(:bound => minimum))
          elsif maximum
            Length::Maximum.new(attribute_name, options.merge(:bound => maximum))
          else
            # raise ArgumentError, "expected one of :is, :equals, :within, :in, :minimum, :min, :maximum, or :max; got #{options.keys.inspect}"
            warn "expected length specification: one of :is, :equals, :in, :within, :min, :minimum, :max, or :maximum; got #{options.keys.inspect}"
            Length::Dummy.new(attribute_name, options)
          end

        [rule]
      end

      class Dummy < Length
      end

      def valid_value?(value)
        skip?(value) || expected_length?(value_length(value))
      end

      def expected_length?(length)
        raise NotImplementedError, "#{self.class}#valid_length? must be implemented"
      end

      # Return the length in characters
      #
      # @param [#length, #to_s] value
      #   the value to get the length of. if it does not respond to #length,
      #   then #to_s will be called, and the length of that will be calculated
      #   instead
      #
      # @return [Integer]
      #   the length of the value
      #
      # @api private
      def value_length(value)
        value.length
      rescue NoMethodError
        value.to_s.length
      end

      if RUBY_VERSION < '1.9'
        # calculate length of multi-byte-encoded strings
        #   as characters rather than bytes
        def value_length(value)
          value.to_s.scan(/./u).size
        end
      end

    end # class Length
  end # class Rule
end # module Aequitas

# meh, I don't like doing this, but the superclass must be loaded before subclasses
require 'aequitas/rule/length/equal'
require 'aequitas/rule/length/range'
require 'aequitas/rule/length/minimum'
require 'aequitas/rule/length/maximum'
