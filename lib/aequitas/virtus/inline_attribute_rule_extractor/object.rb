# -*- encoding: utf-8 -*-

require 'aequitas/virtus/inline_attribute_rule_extractor'

module Aequitas
  module Virtus
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
          rules = []
          rules.concat Array(extract_presence_rules) if options.fetch(:required, false)
          rules.concat Array(extract_length_rules)   if options.fetch(:length,   false)
          rules.concat Array(extract_format_rules)   if options.fetch(:format,   false)
          rules
        end

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
    end # module InlineAttributeRuleExtractor
  end # module Virtus
end # module Aequitas
