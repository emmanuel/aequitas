# -*- encoding: utf-8 -*-

require 'aequitas/rule/value'

module Aequitas
  class Rule
    class Value
      class GreaterThanOrEqual < Value

        def expected_value?(value)
          value >= expected
        rescue ArgumentError
          # TODO: figure out better solution for: can't compare String with Integer
          true
        end

        def violation_type
          :greater_than_or_equal_to
        end

        def violation_data(resource)
          [ [ :minimum, expected ] ]
        end

      end # class GreaterThanOrEqual
    end # class Value
  end # class Rule
end # module Aequitas
