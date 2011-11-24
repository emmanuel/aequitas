# -*- encoding: utf-8 -*-

require 'aequitas/contextual_rule_set'
require 'aequitas/macros'

module Aequitas
  module ClassMethods
    include Macros

    # Return the ContextualRuleSet for this model
    #
    # @api public
    def validation_rules
      @validation_rules ||= ContextualRuleSet.new(self)
    end

  private

    # @api private
    def inherited(base)
      super
      base.validation_rules.concat(validation_rules)
    end

  end # module ClassMethods
end # module Aequitas
