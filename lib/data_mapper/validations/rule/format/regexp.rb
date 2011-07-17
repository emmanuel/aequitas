# -*- encoding: utf-8 -*-

require 'data_mapper/validations/rule/format'

module DataMapper
  module Validations
    class Rule
      module Format

        class Regexp < Rule

          include Format

          EQUALIZE_ON = superclass::EQUALIZE_ON.dup << :format_name << :format

          equalize *EQUALIZE_ON


          attr_reader :format_name

          def initialize(attribute_name, options = {})
            @format_name = options[:format_name]

            super(attribute_name, DataMapper::Ext::Hash.except(options, :format_name))
          end

          def valid?(resource)
            value = resource.validation_property_value(attribute_name)
            return true if optional?(value)

            match_value = value.kind_of?(Numeric) ? value.to_s : value
            match_value =~ self.format
          rescue ::Encoding::CompatibilityError
            # This is to work around a bug in jruby - see formats/email.rb
            false
          end

          def violation_type(resource)
            :invalid
          end

          # TODO: integrate format into error message key?
          # def error_message_args
          #   if format.is_a?(Symbol)
          #     [ :"invalid_#{format}", attribute_name ]
          #   else
          #     [ :invalid, attribute_name ]
          #   end
          # end

        end # class Regexp

      end # module Format
    end # class Rule
  end # module Validations
end # module DataMapper