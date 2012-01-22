# -*- encoding: utf-8 -*-

require 'aequitas/rule'

module Aequitas
  class Rule
    class Confirmation < Rule

      equalize_on *(superclass.equalizer.keys + [:confirmation_attribute_name])

      attr_reader :confirmation_attribute_name

      def initialize(attribute_name, options = {})
        super

        @confirmation_attribute_name = options.fetch(:confirm) do
          :"#{attribute_name}_confirmation"
        end

        skip_condition.default_to_allowing_nil!
        skip_condition.default_to_allowing_blank!
      end

      def validate(resource)
        value = attribute_value(resource)

        if skip?(value) || value == confirmation_value(resource)
          nil
        else
          Violation::Rule.new(resource, custom_message, :rule => self)
        end
      end

      def confirmation_value(resource)
        resource.instance_variable_get("@#{@confirmation_attribute_name}")
      end

      def violation_type(resource)
        :confirmation
      end

    end # class Confirmation
  end # class Rule
end # module Aequitas
