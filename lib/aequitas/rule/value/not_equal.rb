# -*- encoding: utf-8 -*-

require 'aequitas/rule/value'

module Aequitas
  class Rule
    class Value
      class NotEqual < Value

        def expected_value?(value)
          value != expected
        rescue ArgumentError
          # TODO: figure out better solution for: can't compare String with Integer
          true
        end

        def violation_type
          :not_equal_to
        end

        def violation_data
          [ [ :not_expected, expected ] ]
        end

      end # class NotEqual
    end # class Value
  end # class Rule
end # module Aequitas
