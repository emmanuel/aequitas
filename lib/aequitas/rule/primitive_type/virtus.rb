# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    class PrimitiveType
      class Virtus < PrimitiveType

        attr_reader :attribute

        def initialize(attribute_name, options = {})
          @attribute = options.fetch(:attribute)

          options[:primitive] ||= attribute.class.primitive

          super(attribute_name, options)
        end

        def expected_type?(value)
          attribute.value_coerced?(value)
        end

      end # class Virtus
    end # class PrimitiveType
  end # class Rule
end # module Aequitas
