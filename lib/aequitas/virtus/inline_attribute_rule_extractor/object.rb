# -*- encoding: utf-8 -*-

require 'aequitas/virtus/inline_attribute_rule_extractor'

module Aequitas
  module Virtus
    class InlineAttributeRuleExtractor
      class Object < InlineAttributeRuleExtractor

        def extract_presence_rules
          Rule::Presence::NotBlank.new(attribute.name)
        end

        def extract_length_rules
          nil
        end

        def extract_format_rules
          nil
        end

      end # class Object
    end # class InlineAttributeRuleExtractor
  end # module Virtus
end # module Aequitas
