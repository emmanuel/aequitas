# -*- encoding: utf-8 -*-

require 'aequitas/rule/format'

module Aequitas
  class Rule
    module Format
      class Regexp < Rule

        include Format

        equalize_on *(superclass.equalizer.keys + [:format, :format_name])

        attr_reader :format_name

        def initialize(attribute_name, options = {})
          super

          @format_name = options.fetch(:format_name, nil)
        end

        def valid?(resource)
          value = attribute_value(resource)
          return true if skip?(value)

          value ? value.to_s =~ self.format : false
        rescue ::Encoding::CompatibilityError
          # This is to work around a bug in jruby - see formats/email.rb
          false
        end

        # TODO: integrate format into error message key?
        # def error_message_args
        #   if format_name.is_a?(Symbol)
        #     [ :"invalid_#{format_name}", attribute_name ]
        #   else
        #     [ :invalid, attribute_name ]
        #   end
        # end

      end # class Regexp
    end # module Format
  end # class Rule
end # module Aequitas
