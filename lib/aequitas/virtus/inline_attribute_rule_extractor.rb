module Aequitas
  module Virtus
    module InlineAttributeRuleExtractor

      def self.extract(attribute)
        type = 
          case attribute
          when ::Virtus::Attribute::Boolean;  self::Boolean
          when ::Virtus::Attribute::String;   self::String
          # when ::Virtus::Attribute::Decimal;  self::Decimal
          # when ::Virtus::Attribute::Float;    self::Float
          when ::Virtus::Attribute::Numeric;  self::Numeric
          when ::Virtus::Attribute::Object;   self::Object
          end

        type.new(attribute).extract
      end

    end # module InlineAttributeRuleExtractor
  end # module Virtus
end # module Aequitas

require 'aequitas/virtus/inline_attribute_rule_extractor/object'
require 'aequitas/virtus/inline_attribute_rule_extractor/boolean'
require 'aequitas/virtus/inline_attribute_rule_extractor/string'
require 'aequitas/virtus/inline_attribute_rule_extractor/numeric'
