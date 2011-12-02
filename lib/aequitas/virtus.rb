module Virtus
  class Attribute
    Object.accept_options  :required# , :prohibited, :forbidden # hmm...
    String.accept_options  :length, :format
    Decimal.accept_options :precision, :scale
    Float.accept_options   :precision, :scale
  end
end

module Aequitas
  module ClassMethods
    def self.extended(base)
      super
      base.extend Aequitas::Virtus::ClassMethodOverrides
    end
  end

  module Virtus
    module ClassMethodOverrides
      def virtus_add_attribute(attribute)
        super
        inline_attribute_rules = InlineAttributeRuleExtractor.extract(attribute)
        validation_rules.context(:default).concat(inline_attribute_rules)
      end
    end

    class InlineAttributeRuleExtractor
      attr_reader :attribute

      def self.extract(attribute)
        new(attribute).extract
      end

      def initialize(attribute)
        @attribute = attribute
      end

      def extract
        rules = []
        rules.concat Array(extract_presence_rules)
        rules.concat Array(extract_length_rules)
        rules.concat Array(extract_format_rules)
        rules
      end

      def extract_presence_rules
        nil
      end

      def extract_length_rules
        nil
      end

      def extract_format_rules
        nil
      end
    end
  end
end
