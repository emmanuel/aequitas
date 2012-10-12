# -*- encoding: utf-8 -*-

module Aequitas
  module VirtusIntegration
    module InlineAttributeRuleExtractor
      class String < Object

        def extract
          rules = super
          rules.concat(Array(extract_length_rules))
          rules.concat(Array(extract_format_rules))
        end

        def extract_format_rules
          format = options.fetch(:format, false)
          Rule::Format.rules_for(attribute.name, :with => format) if format
        end

      end # class String
    end # module InlineAttributeRuleExtractor
  end # module VirtusIntegration
end # module Aequitas
