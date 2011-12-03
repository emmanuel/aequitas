require 'aequitas/virtus/inline_attribute_rule_extractor'

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
  end
end
