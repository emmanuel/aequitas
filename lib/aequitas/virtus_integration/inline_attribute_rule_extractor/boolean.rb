# -*- encoding: utf-8 -*-

module Aequitas
  module VirtusIntegration
    module InlineAttributeRuleExtractor
      class Boolean < Object

        def extract_presence_rule
          Rule::Presence::NotNil.new(attribute.name)
        end

      end # class Boolean
    end # module InlineAttributeRuleExtractor
  end # module VirtusIntegration
end # module Aequitas
