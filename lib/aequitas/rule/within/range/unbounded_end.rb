# -*- encoding: utf-8 -*-

require 'aequitas/rule/within/range'

module Aequitas
    class Rule
      module Within
        module Range

          class UnboundedEnd < Rule

            include Range

            def violation_type(resource)
              :greater_than_or_equal_to
            end

            def violation_data(resource)
              [ [ :minimum, range.begin ] ]
            end

          end # class UnboundedBegin

        end # module Range
      end # module Within
    end # class Rule
end # module Aequitas
