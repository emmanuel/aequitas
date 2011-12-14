# -*- encoding: utf-8 -*-

require 'aequitas/rule/within/range'

module Aequitas
  class Rule
    class Within
      class Range
        class UnboundedEnd < Range

          def violation_type(resource)
            :greater_than_or_equal_to
          end

          def violation_data(resource)
            [ [ :minimum, range.begin ] ]
          end

        end # class UnboundedBegin
      end # class Range
    end # class Within
  end # class Rule
end # module Aequitas
