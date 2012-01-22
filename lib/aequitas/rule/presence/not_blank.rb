# -*- encoding: utf-8 -*-

require 'aequitas/rule/presence'

module Aequitas
  class Rule
    class Presence
      class NotBlank < Presence

        def valid_value?(value)
          !Aequitas.blank?(value)
        end

        def violation_type(resource)
          :blank
        end

      end # class NonNil
    end # class Presence
  end # class Rule
end # module Aequitas
