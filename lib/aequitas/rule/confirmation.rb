# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    class Confirmation < Rule

      equalize(:confirmation_attribute_name)

      attr_reader :confirmation_attribute_name

      def initialize(attribute_name, options = {})
        super

        @confirmation_attribute_name = options.fetch(:confirm) do
          :"#{attribute_name}_confirmation"
        end
      end

      def validate(resource)
        value = attribute_value(resource)

        if skip?(value) || value == confirmation_value(resource)
          nil
        else
          new_violation(resource, value)
        end
      end

      def confirmation_value(resource)
        resource.validation_attribute_value(@confirmation_attribute_name)
      end

      def violation_type
        :confirmation
      end

    end # class Confirmation
  end # class Rule
end # module Aequitas
