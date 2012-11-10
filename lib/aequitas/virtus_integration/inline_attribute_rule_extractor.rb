# -*- encoding: utf-8 -*-

module Aequitas
  module VirtusIntegration
    module InlineAttributeRuleExtractor

      def self.extract(attribute)
        type = 
          case attribute
          when ::Virtus::Attribute::Boolean;  self::Boolean
          when ::Virtus::Attribute::String;   self::String
          when ::Virtus::Attribute::Array;    self::Array
          # when ::Virtus::Attribute::Decimal;  self::Decimal
          # when ::Virtus::Attribute::Float;    self::Float
          when ::Virtus::Attribute::Numeric;  self::Numeric
          when ::Virtus::Attribute::Object;   self::Object
          end

        type.new(attribute).extract
      end

    end # module InlineAttributeRuleExtractor
  end # module VirtusIntegration
end # module Aequitas
