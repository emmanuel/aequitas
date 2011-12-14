# -*- encoding: utf-8 -*-

require 'aequitas/rule/magnitude'

module Aequitas
  class Rule
    class Magnitude
      class NotEqual < Magnitude

        def valid_magnitude?(value)
          value != expected
        rescue ArgumentError
          # TODO: figure out better solution for: can't compare String with Integer
          true
        end

        def violation_type(resource)
          :not_equal_to
        end

        def violation_data(resource)
          [ [ :not_expected, expected ] ]
        end

      end # class NotEqual
    end # class Magnitude
  end # class Rule
end # module Aequitas
