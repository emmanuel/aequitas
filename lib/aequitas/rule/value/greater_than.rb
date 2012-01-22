# -*- encoding: utf-8 -*-

require 'aequitas/rule/value'

module Aequitas
  class Rule
    class Value
      class GreaterThan < Value

        def expected_value?(value)
          value > expected
        rescue ArgumentError
          # TODO: figure out better solution for: can't compare String with Integer
          true
        end

        def violation_type
          :greater_than
        end

        def violation_data
          [ [ :minimum, expected ] ]
        end

      end # class GreaterThan
    end # class Value
  end # class Rule
end # module Aequitas
