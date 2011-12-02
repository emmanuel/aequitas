# -*- encoding: utf-8 -*-

require 'aequitas/rule/absence'

module Aequitas
  class Rule
    class Absence
      class Blank < Absence

        def valid?(resource)
          Aequitas.blank?(attribute_value(resource))
        end

        def violation_type(resource)
          :not_blank
        end

      end # class Blank
    end # class Absence
  end # class Rule
end # module Aequitas
