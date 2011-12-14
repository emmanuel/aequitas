# -*- encoding: utf-8 -*-

require 'aequitas/rule/within/range'

module Aequitas
  class Rule
    class Within
      class Range
        class UnboundedBegin < Range

          def violation_type(resource)
            :less_than_or_equal_to
          end

          def violation_data(resource)
            [ [ :maximum, range.max ] ]
          end

        end # class UnboundedBegin
      end # class Range
    end # class Within
  end # class Rule
end # module Aequitas
