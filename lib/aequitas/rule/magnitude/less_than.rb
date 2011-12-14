# -*- encoding: utf-8 -*-

require 'aequitas/rule/magnitude'

module Aequitas
  class Rule
    class Magnitude
      class LessThan < Magnitude

        def valid_magnitude?(value)
          value < expected
        rescue ArgumentError
          # TODO: figure out better solution for: can't compare String with Integer
          true
        end

        def violation_type(resource)
          :less_than
        end

        def violation_data(resource)
          [ [ :maximum, expected ] ]
        end

      end # class LessThan
    end # class Magnitude
  end # class Rule
end # module Aequitas
