# -*- encoding: utf-8 -*-

require 'aequitas/virtus_integration/inline_attribute_rule_extractor/object'

module Aequitas
  module VirtusIntegration
    module InlineAttributeRuleExtractor
      class Boolean < Object

        def extract_presence_rules
          Rule::Presence::NotNil.new(attribute.name)
        end

      end # class Boolean
    end # module InlineAttributeRuleExtractor
  end # module VirtusIntegration
end # module Aequitas
