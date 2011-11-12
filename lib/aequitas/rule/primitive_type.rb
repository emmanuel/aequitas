# -*- encoding: utf-8 -*-

require 'aequitas/rule'

module Aequitas
    class Rule

      class PrimitiveType < Rule

        def valid?(resource)
          property = get_resource_property(resource, attribute_name)
          value    = resource.validation_property_value(attribute_name)

          value.nil? || property.value_dumped?(value)
        end

        def violation_type(resource)
          :primitive
        end

        def violation_data(resource)
          property = get_resource_property(resource, attribute_name)

          [ [ :primitive, property.load_as ] ]
        end

      end # class PrimitiveType

    end # class Rule
end # module Aequitas
