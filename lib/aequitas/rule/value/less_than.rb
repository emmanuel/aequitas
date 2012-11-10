# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    class Value
      class LessThan < Value

        def expected_value?(value)
          value < expected
        rescue ArgumentError
          # TODO: figure out better solution for: can't compare String with Integer
          true
        end

        def violation_type
          :less_than
        end

        def violation_data
          [ [ :maximum, expected ] ]
        end

      end # class LessThan
    end # class Value
  end # class Rule
end # module Aequitas
