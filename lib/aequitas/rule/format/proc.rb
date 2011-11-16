# -*- encoding: utf-8 -*-

require 'aequitas/rule/format'

module Aequitas
  class Rule
    module Format
      class Proc < Rule

        include Format

        EQUALIZE_ON = superclass::EQUALIZE_ON.dup << :format

        equalize *EQUALIZE_ON


        def valid?(resource)
          value = attribute_value(resource)
          return true if skip?(value)

          self.format.call(value)
        # rescue ::Encoding::CompatibilityError
        #   # This is to work around a bug in jruby - see formats/email.rb
        #   false
        end

      end # class Proc
    end # module Format
  end # class Rule
end # module Aequitas
