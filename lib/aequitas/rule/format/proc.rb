# -*- encoding: utf-8 -*-

require 'aequitas/rule/format'

module Aequitas
  class Rule
    class Format
      class Proc < Format

        def valid?(resource)
          value = attribute_value(resource)
          
          skip?(value) || format.call(value)
        # rescue ::Encoding::CompatibilityError
        #   # This is to work around a bug in jruby - see formats/email.rb
        #   false
        end

      end # class Proc
    end # class Format
  end # class Rule
end # module Aequitas
