# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    class Format
      class Regexp < Format

        equalize_on *superclass.equalizer.keys + [:format_name]

        attr_reader :format_name

        def initialize(attribute_name, options = {})
          super

          @format_name = options.fetch(:format_name, nil)
        end

        def expected_format?(value)
          value ? value.to_s =~ self.format : false
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
    end # class Format
  end # class Rule
end # module Aequitas
