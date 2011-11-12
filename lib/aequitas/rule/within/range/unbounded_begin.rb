# -*- encoding: utf-8 -*-

require 'aequitas/rule/within/range'

module Aequitas
    class Rule
      module Within
        module Range

          class UnboundedBegin < Rule

            include Range

            def violation_type(resource)
              :less_than_or_equal_to
            end

            def violation_data(resource)
              [ [ :maximum, range.max ] ]
            end

          end # class UnboundedBegin

        end # module Range
      end # module Within
    end # class Rule
end # module Aequitas
