# -*- encoding: utf-8 -*-

require 'backports'
require 'bigdecimal'
require 'bigdecimal/util'
require 'forwardable'
require 'adamantium'
require 'equalizer'
require 'abstract_class'

# Library namespace
module Aequitas

  # Return default message transformer
  #
  # @return [MessageTransfomer]
  #
  # @api private
  #
  def self.default_transformer
    @default_transformer ||= MessageTransformer.default
  end

  # Set default message transformer
  #
  # @param [MessageTransformer] transformer
  #
  # @return [self]
  #
  # @api private
  #
  def self.default_transformer=(transformer)
    @default_transformer = transformer
    self
  end

  # Hook called when module is included
  #
  # @param [Module|Class] descendant
  #
  # @api private
  #
  def self.included(descendant)
    super
    descendant.extend(ClassMethods)
  end

  # Check if a resource is valid 
  #
  # @return [true]
  #   if resource is valid
  #
  # @return [false]
  #   otherwise
  #  
  # @api public
  #
  def valid?
    validate.errors.empty?
  end

  # Return violations
  #
  # @return [ViolationSet]
  #   the collection of current validation errors for this resource
  #
  # @api public
  #
  def errors
    @errors ||= ViolationSet.new
  end

  # Command a resource to populate its ViolationSet with any violations of
  #
  # @return [self]
  #
  # @api public
  #
  def validate
    # TODO: errors.replace(validation_violations)
    @errors = ViolationSet.new(validation_violations)

    self
  end

  # Get a list of violations for the receiver *without* mutating it
  # 
  # @api private
  #
  def validation_violations
    validation_rules.validate(self)
  end

  # @return [RuleSet]
  # 
  # @api private
  #
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

require 'aequitas/support/blank'
require 'aequitas/support/value_object'
require 'aequitas/macros'
require 'aequitas/class_methods'
require 'aequitas/rule_set'
require 'aequitas/exceptions'
require 'aequitas/validator'
require 'aequitas/message_transformer'
require 'aequitas/rule'
require 'aequitas/rule/absence'
require 'aequitas/rule/absence/blank'
require 'aequitas/rule/absence/nil'
require 'aequitas/rule/acceptance'
require 'aequitas/rule/block'
require 'aequitas/rule/confirmation'
require 'aequitas/rule/format'
require 'aequitas/rule/format/email_address'
require 'aequitas/rule/format/proc'
require 'aequitas/rule/format/regexp'
require 'aequitas/rule/format/url'
require 'aequitas/rule/guard'
require 'aequitas/rule/length'
require 'aequitas/rule/length/equal'
require 'aequitas/rule/length/maximum'
require 'aequitas/rule/length/minimum'
require 'aequitas/rule/length/range'
require 'aequitas/rule/method'
require 'aequitas/rule/numericalness'
require 'aequitas/rule/numericalness/integer'
require 'aequitas/rule/numericalness/non_integer'
require 'aequitas/rule/presence'
require 'aequitas/rule/presence/not_blank'
require 'aequitas/rule/presence/not_nil'
require 'aequitas/rule/primitive_type'
require 'aequitas/rule/skip_condition'
require 'aequitas/rule/value'
require 'aequitas/rule/value/equal'
require 'aequitas/rule/value/greater_than'
require 'aequitas/rule/value/greater_than_or_equal'
require 'aequitas/rule/value/less_than'
require 'aequitas/rule/value/less_than_or_equal'
require 'aequitas/rule/value/not_equal'
require 'aequitas/rule/value/range'
require 'aequitas/rule/within'
require 'aequitas/rule_set'
require 'aequitas/version'
require 'aequitas/violation'
require 'aequitas/violation/message'
require 'aequitas/violation/rule'
require 'aequitas/violation_set'
