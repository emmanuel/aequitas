# -*- encoding: utf-8 -*-

require 'aequitas/rule/presence'

module Aequitas
  class Rule
    class Presence
      class NotNil < Presence

        def valid_value?(value)
          !value.nil?
        end

        def violation_type(resource)
          :nil
        end

      end # class NonNil
    end # class Presence
  end # class Rule
end # module Aequitas
