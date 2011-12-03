module Aequitas
  module Virtus
    class InlineAttributeRuleExtractor

      def self.extract(attribute)
        type = 
          case attribute
          when ::Virtus::Attribute::Boolean;  self::Boolean
          when ::Virtus::Attribute::String;   self::String
          # when ::Virtus::Attribute::Decimal;  self::Decimal
          # when ::Virtus::Attribute::Float;    self::Float
          when ::Virtus::Attribute::Object;   self::Object
          end
        type.new(attribute).extract
      end

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

    end
  end # module Virtus
end # module Aequitas
  