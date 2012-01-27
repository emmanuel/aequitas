# -*- encoding: utf-8 -*-

require 'aequitas/exceptions'
require 'aequitas/support/value_object'
require 'aequitas/message_transformer'

module Aequitas
  class Violation
    class Rule < Violation

      # Configure a Violation instance
      # 
      # @param [Object] resource
      #   the validated object
      # @param [String, #call, Hash] message
      #   an optional custom message for this Violation
      # @param [Rule] rule
      #   the Rule whose violation triggered the creation of the receiver
      #
      # @api private
      def initialize(resource, message, options = {})
        super

        @rule  = options.fetch(:rule)
        @value = options.fetch(:value, nil)
      end

      # Name of the attribute which this Violation pertains to
      #
      # @return [Symbol]
      #   the name of the validated attribute associated with this violation
      #
      # @api public
      def attribute_name
        rule.attribute_name
      end

      # @api public
      def type
        rule.violation_type
      end

      # @api public
      def info
        rule.violation_info.merge(:value => @value)
      end

      # @api public
      def values
        rule.violation_values
      end

    end # class Rule
  end # class Violation
end # module Aequitas
