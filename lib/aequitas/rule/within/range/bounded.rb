# -*- encoding: utf-8 -*-

require 'aequitas/rule/within/range'

module Aequitas
    class Rule
      module Within
        module Range

          class Bounded < Rule

            include Range

            def violation_type(resource)
              :value_between
            end

            def violation_data(resource)
              [ [ :minimum, range.begin ], [ :maximum, range.end ] ]
            end

          end # class Bounded

        end # module Range
      end # module Within
    end # class Rule
end # module Aequitas
