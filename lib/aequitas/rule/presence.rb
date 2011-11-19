# -*- encoding: utf-8 -*-

require 'aequitas/rule'

module Aequitas
  class Rule
    class Presence < Rule

      def initialize(attribute_name, options = {})
        super

        skip_condition.reject_nil!
        skip_condition.reject_blank!
      end

      # Boolean property types are considered present if non-nil.
      # Other property types are considered present if non-blank.
      # Non-properties are considered present if non-blank.
      def valid?(resource)
        value = attribute_value(resource)

        boolean_type?(resource) ? !value.nil? : !Aequitas.blank?(value)
      end

      def violation_type(resource)
        boolean_type?(resource) ? :nil : :blank
      end

      # Is the property a boolean property?
      #
      # @return [Boolean]
      #   Returns true for Boolean, ParanoidBoolean, TrueClass and other
      #   properties. Returns false for other property types or for
      #   non-properties.
      # 
      # @api private
      # 
      # TODO: break this into concrete types and move the property check
      # into #initialize. Will require adding model to signature of #initialize
      def boolean_type?(resource)
        return false # TODO: rework this to be independent of DM
        property = get_resource_property(resource, attribute_name)

        property ? property.load_as == TrueClass : false
      end

    end # class Presence
  end # class Rule
end # module Aequitas
