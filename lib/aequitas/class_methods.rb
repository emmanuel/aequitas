# -*- encoding: utf-8 -*-


module Aequitas
  module ClassMethods
    include Macros

    # Return the RuleSet for this model
    #
    # @return [RuleSet]
    #
    # @api private
    #
    def validation_rules
      @validation_rules ||= RuleSet.new
    end

  private

    # Hook called when module is included
    #
    # @param [Class|Module] descendant
    #
    # @api private
    #
    def inherited(descendant)
      super
      descendant.validation_rules.concat(validation_rules)
    end

  end # module ClassMethods
end # module Aequitas
