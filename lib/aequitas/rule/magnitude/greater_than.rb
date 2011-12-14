# -*- encoding: utf-8 -*-

require 'aequitas/rule/magnitude'

module Aequitas
  class Rule
    class Magnitude
      class GreaterThan < Magnitude

        def valid_magnitude?(value)
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
    end # class Magnitude
  end # class Rule
end # module Aequitas
