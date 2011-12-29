# -*- encoding: utf-8 -*-

require 'aequitas/virtus_integration/inline_attribute_rule_extractor'

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
          Array(extract_presence_rules)
        end

        def extract_presence_rules
          required = options.fetch(:required, false)
          Rule::Presence::NotBlank.new(attribute.name) if required
        end

      end # class Object
    end # module InlineAttributeRuleExtractor
  end # module VirtusIntegration
end # module Aequitas
