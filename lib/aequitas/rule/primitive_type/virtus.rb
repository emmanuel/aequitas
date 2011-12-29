# -*- encoding: utf-8 -*-

require 'aequitas/rule/primitive_type'

module Aequitas
  class Rule
    class PrimitiveType
      class Virtus < PrimitiveType

        attr_reader :attribute

        def initialize(attribute_name, options = {})
          @attribute = options.fetch(:attribute)

          super(attribute_name, :primitive => attribute.class.primitive)
        end

        def primitive?(value)
          attribute.value_coerced?(value)
        end

      end # class Virtus
    end # class PrimitiveType
  end # class Rule
end # module Aequitas
