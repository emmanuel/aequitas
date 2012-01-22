# -*- encoding: utf-8 -*-

require 'aequitas/rule/absence'

module Aequitas
  class Rule
    class Absence
      class Blank < Absence

        def valid_value?(value)
          Aequitas.blank?(value)
        end

        def violation_type(resource)
          :not_blank
        end

      end # class Blank
    end # class Absence
  end # class Rule
end # module Aequitas
