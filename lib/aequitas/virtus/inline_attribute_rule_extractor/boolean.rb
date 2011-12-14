# -*- encoding: utf-8 -*-

require 'aequitas/virtus/inline_attribute_rule_extractor/object'

module Aequitas
  module Virtus
    module InlineAttributeRuleExtractor
      class Boolean < Object

        def extract_presence_rules
          Rule::Presence::NotNil.new(attribute.name)
        end

      end # class Boolean
    end # module InlineAttributeRuleExtractor
  end # module Virtus
end # module Aequitas
