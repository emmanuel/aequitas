# -*- encoding: utf-8 -*-

require 'aequitas/virtus/inline_attribute_rule_extractor/object'

module Aequitas
  module Virtus
    module InlineAttributeRuleExtractor
      class String < Object

        def extract_length_rules
          length = attribute.options.fetch(:length)

          case length
          when Integer; Rule::Length::Equal.new(attribute.name, :expected => length)
          when Range;   Rule::Length::Range.new(attribute.name, :range    => length)
          end
        end

        def extract_format_rules
          format = attribute.options.fetch(:format)
          Rule::Format.new(attribute.name, :with => format)
        end

      end # class String
    end # module InlineAttributeRuleExtractor
  end # module Virtus
end # module Aequitas
