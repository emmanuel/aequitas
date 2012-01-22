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

        @rule = options.fetch(:rule)
      end

      # @api public
      def attribute_name
        rule.attribute_name
      end

      # @api private
      def type
        rule.violation_type
      end

      # @api private
      def info
        rule.violation_info(resource)
      end

      # @api private
      def values
        rule.violation_values(resource)
      end

    end # class Rule
  end # class Violation
end # module Aequitas
