# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    class Absence
      class Nil < Absence

        def valid_value?(value)
          value.nil?
        end

        def violation_type
          :not_nil
        end

      end # class Nil
    end # class Absence
  end # class Rule
end # module Aequitas
