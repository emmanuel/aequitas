# -*- encoding: utf-8 -*-

module Aequitas
  module VirtusIntegration
    module InlineAttributeRuleExtractor
      class Object

        attr_reader :attribute

        def initialize(attribute)
          @attribute = attribute
        end

        def options
          attribute.options
        end

        def extract
          inline_rules = []
          inline_rules.concat Array(extract_presence_rule)
          # inline_rules.concat Array(extract_primitive_type_rule)
        end

        def extract_length_rules
          length = options.fetch(:length, false)

          case length
          when ::Integer; Rule::Length::Equal.new(attribute.name, :expected => length)
          when ::Range;   Rule::Length::Range.new(attribute.name, :range    => length)
          when ::FalseClass;
          else raise ArgumentError, "expected Integer or Range :length, got: #{length.inspect}"
          end
        end

        def extract_presence_rule
          required = options.fetch(:required, false)
          Rule::Presence::NotBlank.new(attribute.name) if required
        end

        def extract_primitive_type_rule
          Rule::PrimitiveType::Virtus.new(attribute.name, :attribute => attribute)
        end

      end # class Object
    end # module InlineAttributeRuleExtractor
  end # module VirtusIntegration
end # module Aequitas
