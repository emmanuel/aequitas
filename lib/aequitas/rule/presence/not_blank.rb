# -*- encoding: utf-8 -*-

require 'aequitas/rule/presence'

module Aequitas
  class Rule
    class Presence
      class NotBlank < Presence

        def valid?(resource)
          !Aequitas.blank?(attribute_value(resource))
        end

        def violation_type(resource)
          :blank
        end

      end # class NonNil
    end # class Presence
  end # class Rule
end # module Aequitas
