# -*- encoding: utf-8 -*-

require 'aequitas/rule/value'

module Aequitas
  class Rule
    class Value
      class Equal < Value

        def expected_value?(value)
          value == expected
        rescue ArgumentError
          # TODO: figure out better solution for: can't compare String with Integer
          true
        end

        def violation_type
          :equal_to
        end

        def violation_data
          [ [ :expected, expected ] ]
        end

      end # class Equal
    end # class Value
  end # class Rule
end # module Aequitas
