# -*- encoding: utf-8 -*-

require 'aequitas/rule'

module Aequitas
  class Rule
    class PrimitiveType < Rule

      attr_reader :primitive

      def initialize(attribute_name, options = {})
        super

        @primitive = options.fetch(:primitive)
      end

      def valid_value?(value)
        skip?(value) || expected_type?(value)
      end

      def expected_type?(value)
        value.is_a?(primitive)
      end

      def violation_type(resource)
        :primitive
      end

      def violation_data(resource)
        [ [ :primitive, primitive ] ]
      end

    end # class PrimitiveType
  end # class Rule
end # module Aequitas

require 'aequitas/rule/primitive_type/virtus'
