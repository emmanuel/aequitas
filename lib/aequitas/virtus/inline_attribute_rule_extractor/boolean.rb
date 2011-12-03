module Aequitas
  module Virtus
    class InlineAttributeRuleExtractor
      class Boolean < Object

        def extract_presence_rules
          Rule::Presence::NotNil.new(attribute.name)
        end

      end # class Boolean
    end # class InlineAttributeRuleExtractor
  end # module Virtus
end # module Aequitas
