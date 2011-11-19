# -*- encoding: utf-8 -*-

require 'aequitas/rule'

module Aequitas
  class Rule
    class Absence < Rule

      def initialize(attribute_name, options = {})
        super

        skip_condition.reject_nil!
        skip_condition.reject_blank!
      end

      def valid?(resource)
        Aequitas.blank?(attribute_value(resource))
      end

      def violation_type(resource)
        :absent
      end

    end # class Absence
  end # class Rule
end # module Aequitas
