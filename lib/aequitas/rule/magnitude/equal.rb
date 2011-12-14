# -*- encoding: utf-8 -*-

require 'aequitas/rule/magnitude'

module Aequitas
  class Rule
    class Magnitude
      class Equal < Magnitude

        def valid_magnitude?(value)
          value == expected
        rescue ArgumentError
          # TODO: figure out better solution for: can't compare String with Integer
          true
        end

        def violation_type(resource)
          :equal_to
        end

        def violation_data(resource)
          [ [ :expected, expected ] ]
        end

      end # class Equal
    end # class Magnitude
  end # class Rule
end # module Aequitas
