# -*- encoding: utf-8 -*-

if RUBY_VERSION < '1.9'
  require 'backports'
end

require 'aequitas/version'


require 'aequitas/class_methods'
require 'aequitas/violation_set'

module Aequitas

  def self.included(base)
    super
    base.extend ClassMethods
  end

  # Check if a resource is valid in a given context
  #
  # @api public
  def valid?(context_name = default_validation_context)
    validate(context_name).errors.empty?
  end

  # @return [ViolationSet]
  #   the collection of current validation errors for this resource
  #
  # @api public
  def errors
    @errors ||= ViolationSet.new(self)
  end

  # Command a resource to populate its ViolationSet with any violations of
  # its validation Rules in +context_name+
  #
  # @api public
  def validate(context_name = default_validation_context)
    # TODO: errors.replace(validation_violations(context_name))
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

  # The name of the default validation context for this Resource.
  #
  # Overriding #default_validation_context .
  # 
  # @return [Symbol]
  #   the current validation context from the context stack
  #   (if valid for this model), or :default
  # 
  # @api public
  def default_validation_context
    :default
  end

  # @return [ContextualRuleSet]
  # 
  # @api private
  def validation_rules
    self.class.validation_rules
  end

  # Retrieve the value of the given property name for the purpose of validation
  #
  # Defaults to sending the attribute name arg to the receiver and
  # using the resulting value as the attribute value for validation
  #
  # @param [Symbol] attribute_name
  #   the name of the attribute for which to retrieve
  #   the attribute value for validation.
  #
  # @return [Object]
  #   the value of the attribute identified by +attribute_name+
  #   for the purpose of validation
  #
  # @api public
  def validation_attribute_value(attribute_name)
    __send__(attribute_name) if respond_to?(attribute_name, true)
  end

end # module Aequitas
