# -*- encoding: utf-8 -*-


module Aequitas
  module ClassMethods
    include Macros

    # Return the RuleSet for this model
    #
    # @api public
    def validation_rules
      @validation_rules ||= RuleSet.new
    end

  private

    # @api private
    def inherited(base)
      super
      base.validation_rules.concat(validation_rules)
    end

  end # module ClassMethods
end # module Aequitas
