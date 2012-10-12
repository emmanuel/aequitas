# -*- encoding: utf-8 -*-

module Aequitas
  module VirtusIntegration
    module InlineAttributeRuleExtractor
      class Array < Object

        def extract
          rules = super
          rules.concat Array(extract_length_rules)
        end

      end # class Array
    end # module InlineAttributeRuleExtractor
  end # module VirtusIntegration
end # module Aequitas
