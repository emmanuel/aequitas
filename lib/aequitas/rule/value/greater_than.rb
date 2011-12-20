# -*- encoding: utf-8 -*-

require 'aequitas/rule/value'

module Aequitas
  class Rule
    class Value
      class GreaterThan < Value

        def valid_value?(value)
          value > expected
        rescue ArgumentError
          # TODO: figure out better solution for: can't compare String with Integer
          true
        end

        def violation_type(resource)
          :greater_than
        end

        def violation_data(resource)
          [ [ :minimum, expected ] ]
        end

      end # class GreaterThan
    end # class Value
  end # class Rule
end # module Aequitas
