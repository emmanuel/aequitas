# -*- encoding: utf-8 -*-

require 'aequitas/rule'

module Aequitas
  class Rule
    class Confirmation < Rule

      equalize_on superclass.equalizer.keys + [:confirmation_attribute]

      attr_reader :confirmation_attribute


      def initialize(attribute_name, options = {})
        super

        @confirm_attribute_name = options.fetch(:confirm) do
          :"#{attribute_name}_confirmation"
        end

        allow_nil!   unless defined?(@allow_nil)
        allow_blank! unless defined?(@allow_blank)
      end

      def valid?(resource)
        value = attribute_value(resource)
        return true if skip?(value)

        value == confirmation_value(resource)
      end

      def confirmation_value(resource)
        resource.instance_variable_get("@#{@confirm_attribute_name}")
      end

      def violation_type(resource)
        :confirmation
      end

    end # class Confirmation
  end # class Rule
end # module Aequitas
