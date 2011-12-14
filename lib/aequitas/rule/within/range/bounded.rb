# -*- encoding: utf-8 -*-

require 'aequitas/rule/within/range'

module Aequitas
  class Rule
    class Within
      class Range
        class Bounded < Range

          def violation_type(resource)
            :value_between
          end

          def violation_data(resource)
            [ [ :minimum, range.begin ], [ :maximum, range.end ] ]
          end

        end # class Bounded
      end # class Range
    end # class Within
  end # class Rule
end # module Aequitas
