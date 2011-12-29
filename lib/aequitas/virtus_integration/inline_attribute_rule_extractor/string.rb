# -*- encoding: utf-8 -*-

require 'aequitas/virtus_integration/inline_attribute_rule_extractor/object'

module Aequitas
  module VirtusIntegration
    module InlineAttributeRuleExtractor
      class String < Object

        def extract
          rules = super
          rules.concat(Array(extract_length_rules))
          rules.concat(Array(extract_format_rules))
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

        def extract_format_rules
          format = options.fetch(:format, false)
          Rule::Format.rules_for(attribute.name, :with => format) if format
        end

      end # class String
    end # module InlineAttributeRuleExtractor
  end # module VirtusIntegration
end # module Aequitas
