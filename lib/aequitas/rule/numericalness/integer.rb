# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    class Numericalness
      class Integer < Numericalness

        def expected
          /\A[+-]?\d+\z/
        end

        def violation_type
          :not_an_integer
        end

      end # class Equal
    end # class Numericalness
  end # class Rule
end # module Aequitas
