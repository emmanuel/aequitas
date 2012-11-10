# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    class Value
      class Range < Value

        def expected_value?(value)
          expected.cover?(value)
        end

        def violation_type
          :value_between
        end

        def violation_data
          [ [ :minimum, expected.begin ], [ :maximum, expected.end ] ]
        end

      end # class Range
    end # class Value
  end # class Rule
end # module Aequitas
