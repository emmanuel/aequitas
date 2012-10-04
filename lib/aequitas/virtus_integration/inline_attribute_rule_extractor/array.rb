# -*- encoding: utf-8 -*-

module Aequitas
  module VirtusIntegration
    module InlineAttributeRuleExtractor
      class Array < Object

        def extract
          rules = super
          rules.concat Array(extract_length_rules)
        end

        def extract_length_rules
          length = options.fetch(:length, false)

          case length
          when ::Integer; Rule::Length::Equal.new(attribute.name, :expected => length)
          when ::Range;   Rule::Length::Range.new(attribute.name, :range    => length)
          when ::FalseClass;
          else raise ArgumentError, "expected Integer or Range :length, got: #{length.inspect}"
          end
        end

      end # class Array
    end # module InlineAttributeRuleExtractor
  end # module VirtusIntegration
end # module Aequitas
