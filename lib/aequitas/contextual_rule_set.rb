# -*- encoding: utf-8 -*-

require 'forwardable'
require 'aequitas/support/equalizable'
require 'aequitas/exceptions'
require 'aequitas/context'
require 'aequitas/rule_set'

module Aequitas
  class ContextualRuleSet
    extend Equalizable
    extend Forwardable
    include Enumerable

    equalize_on :rule_sets

    # MessageTransformer to use for transforming Violations on Resources
    # instantiated from the model to which this ContextualRuleSet is bound
    #
    # @api public
    # attr_accessor :transformer

    # @api private
    attr_reader :rule_sets

    def_delegators :rule_sets, :each, :empty?

    # Clear all named context rule sets
    #
    # @api public
    def_delegators :rule_sets, :clear

    def initialize
      @rule_sets = Hash.new
      define_context(:default)
    end

    def define_context(context_name)
      rule_sets.fetch(context_name) do |context_name|
        rule_sets[context_name] = RuleSet.new
      end

      self
    end

    # Delegate #validate to RuleSet
    #
    # @api public
    def validate(resource, context_name)
      context(context_name).validate(resource)
    end

    # Return the RuleSet for a given context name
    #
    # @param [String] name
    #   Context name for which to return a RuleSet
    # @return [RuleSet]
    #   RuleSet for the given context
    #
    # @api public
    def context(context_name)
      rule_sets.fetch(context_name)
    end

    # Retrieve Rules applicable to a given attribute name
    #
    # @param [Symbol] attribute_name
    #   name of the attribute for which to retrieve applicable Rules
    #
    # @return [Array]
    #   list of Rules applicable to +attribute_name+
    def [](attribute_name)
      context(:default).fetch(attribute_name, [])
    end

    # Create a new rule of the given class for each name in +attribute_names+
    # and add the rules to the RuleSet(s) indicated
    #
    # @param [Aequitas::Rule] rule_class
    #    Rule class, example: Aequitas::Rule::Presence
    #
    # @param [Array<Symbol>] attribute_names
    #    Attribute names given to validation macro, example:
    #    [:first_name, :last_name] in validates_presence_of :first_name, :last_name
    #
    # @param [Hash] options
    #    Options supplied to validation macro, example:
    #    {:context=>:default, :maximum=>50, :allow_nil=>true, :message=>nil}
    #
    # @option [Symbol] :context, :group, :when, :on
    #   the context in which the new rule should be run
    #
    # @return [self]
    def add(rule_class, attribute_names, options = {}, &block)
      context_names = extract_context_names(options)

      attribute_names.each do |attribute_name|
        rules = rule_class.rules_for(attribute_name, options, &block)

        context_names.each { |context| add_rules_to_context(context, rules) }
      end

      self
    end

    # Assimilate all rules contained in +other+ into the receiver
    #
    # @param [ContextualRuleSet] other
    #   the ContextualRuleSet whose rules are to be assimilated
    #
    # @return [self]
    def concat(other)
      other.rule_sets.each do |context_name, rule_set|
        add_rules_to_context(context_name, rules)
      end

      self
    end

    # Define a context and append rules to it
    #
    # @param [Symbol] context_name
    #   name of the context to define and append rules to
    # @param [RuleSet, Array] rules
    #   Rules to append to +context_name+
    #
    # @return [self]
    def add_rules_to_context(context_name, rules)
      define_context(context_name)
      context(context_name).concat(rules)

      self
    end

    # Returns the current validation context on the stack if valid for this contextual rule set,
    #   nil if no RuleSets are defined (and no context names are on the validation context stack),
    #   or :default if the current context is invalid for this rule set or
    #     if no contexts have been defined for this contextual rule set and
    #     no context name is on the stack.
    #
    # @return [Symbol]
    #   the current validation context from the stack (if valid for this model),
    #   nil if no context name is on the stack and no contexts are defined for
    #   this model, or :default if the context on the stack is invalid for
    #   this model or no context is on the stack and this model has at least
    #   one validation context
    #
    # @api private
    #
    # TODO: this logic behind this method is too complicated.
    #   simplify the semantics of #current_context, #validate
    def current_context
      context = Aequitas::Context.current
      valid_context?(context) ? context : :default
    end

    # Test if the validation context name is valid for this contextual rule set.
    #   A validation context name is valid if not nil and either:
    #     1) no rule sets are defined for this contextual rule set
    #   OR
    #     2) there is a rule set defined for the given context name
    #
    # @param [Symbol] context
    #   the context to test
    #
    # @return [Boolean]
    #   true if the context is valid
    #
    # @api private
    def valid_context?(context_name)
      !context_name.nil? && context_defined?(context_name)
    end

    def context_defined?(context_name)
      rule_sets.include?(context_name)
    end

    # Assert that the given validation context name
    #   is valid for this contextual rule set
    #
    # @param [Symbol] context
    #   the context to test
    #
    # @raise [InvalidContextError]
    #   raised if the context is not valid for this contextual rule set
    #
    # @api private
    #
    # TODO: is this method actually needed?
    def assert_valid_context(context_name)
      unless valid_context?(context_name)
        actual   = context_name.inspect
        expected = rule_sets.keys.inspect
        raise InvalidContextError, "#{actual} is an invalid context, known contexts are #{expected}"
      end
    end

  private

    # Allow :context to be aliased to :group, :when & :on
    #
    # @param [Hash] options
    #   the options from which +context_names+ is to be extracted
    #
    # @return [Array(Symbol)]
    #   the context name(s) from +options+
    #
    # @api private
    def extract_context_names(options)
      context_name = [
        options.delete(:context),
        options.delete(:group),
        options.delete(:when),
        options.delete(:on)
      ].compact.first

      Array(context_name || :default)
    end

  end # class ContextualRuleSet
end # module Aequitas
