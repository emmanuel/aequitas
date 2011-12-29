# -*- encoding: utf-8 -*-

require 'aequitas/virtus_integration/inline_attribute_rule_extractor/object'

module Aequitas
  module VirtusIntegration
    module InlineAttributeRuleExtractor
      class Numeric < Object

        def extract
          rules = super
          rules.concat Array(extract_value_rules)
        end

        def extract_value_rules
          Rule::Value.rules_for(attribute.name, options)
        end

      end # class Numeric
    end # module InlineAttributeRuleExtractor
  end # module VirtusIntegration
end # module Aequitas
