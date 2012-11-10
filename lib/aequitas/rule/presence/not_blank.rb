# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    class Presence
      class NotBlank < Presence

        def valid_value?(value)
          !Aequitas.blank?(value)
        end

        def violation_type
          :blank
        end

      end # class NonNil
    end # class Presence
  end # class Rule
end # module Aequitas
