# -*- encoding: utf-8 -*-

require 'aequitas/rule/format'

module Aequitas
  class Rule
    module Format
      class Proc < Rule

        include Format

        equalize_on(superclass.equalizer.keys + [:format])


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
