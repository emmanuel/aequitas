# -*- encoding: utf-8 -*-

module Aequitas
  class Violation
    class Message < Violation

      # Name of the attribute which this Violation pertains to
      #
      # @return [Symbol]
      #   the name of the validated attribute associated with this violation
      #
      # @api public
      attr_reader :attribute_name

      # Configure a Violation instance
      # 
      # @param [Object] resource
      #   the validated object
      # @param [String, #call, Hash] message
      #   an optional custom message for this Violation
      # @param [Symbol] attribute_name
      #   the name of the attribute whose validation rule was violated
      #   or nil, if a Rule was provided.
      # 
      def initialize(resource, message, options = {})
        super

        @attribute_name = options.fetch(:attribute_name)
      end

      # @api public
      def type
        :unspecified
      end

      # @api public
      def info
        { }
      end

      def values
        [ ]
      end

    end # class Message
  end # class Violation
end # module Aequitas
