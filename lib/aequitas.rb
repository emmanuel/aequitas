require 'aequitas/version'

# require 'aequitas/support/ordered_hash'
# 
# require 'aequitas/exceptions'
# require 'aequitas/context'
# require 'aequitas/violation'
# require 'aequitas/violation_set'
# 
# require 'aequitas/rule'
# require 'aequitas/rule_set'
# require 'aequitas/contextual_rule_set'

require 'aequitas/violation_set'
require 'aequitas/contextual_rule_set'
require 'aequitas/macros'

module Aequitas

    def self.included(base)
      base.extend ClassMethods
    end

    # Check if a resource is valid in a given context
    #
    # @api public
    def valid?(context_name = default_validation_context)
      validate(context_name).errors.empty?
    end

    # Command a resource to populate its ViolationSet with any violations of
    # its validation Rules in +context_name+
    #
    # @api public
    def validate(context_name = default_validation_context)
      # errors.replace(validation_violations(context_name))
      errors.clear
      validation_violations(context_name).each { |v| errors.add(v) }

      self
    end

    # Get a list of violations for the receiver *without* mutating it
    # 
    # @api private
    def validation_violations(context_name = default_validation_context)
      validation_rules.validate(self, context_name)
    end

    # @return [ViolationSet]
    #   the collection of current validation errors for this resource
    #
    # @api public
    def errors
      @errors ||= ViolationSet.new(self)
    end

    # The default validation context for this Resource.
    # This Resource's default context can be overridden by implementing
    # #default_validation_context
    # 
    # @return [Symbol]
    #   the current validation context from the context stack
    #   (if valid for this model), or :default
    # 
    # @api public
    def default_validation_context
      validation_rules.current_context
    end

    # @api private
    def validation_rules
      self.class.validation_rules
    end

    # Retrieve the value of the given property name for the purpose of validation.
    # Default implementation is to send the attribute name arg to the receiver
    # and use the resulting value as the attribute value for validation
    # 
    # @param [Symbol] attribute_name
    #   the name of the attribute for which to retrieve
    #   the attribute value for validation.
    # 
    # @api public
    def validation_property_value(attribute_name)
      __send__(attribute_name) if respond_to?(attribute_name, true)
    end

    module ClassMethods
      include Aequitas::Macros

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
