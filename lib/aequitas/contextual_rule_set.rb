# -*- encoding: utf-8 -*-

require 'forwardable'
require 'aequitas/support/value_object'
require 'aequitas/exceptions'
require 'aequitas/rule_set'

module Aequitas
  class ContextualRuleSet
    extend ValueObject
    extend Forwardable
    include Enumerable

    equalize_on :rule_sets

    # MessageTransformer to use for transforming Violations on Resources
    #
    # When set, overrides Violation.default_transformer when transforming
    # violations on instances of the class to which this ContextualRuleSet
    # is attached.
    #
    # @return [MessageTransformer, nil]
    #
    # @api public
    #
    # TODO: rework the default transformer lookup strategy
    #   It's wonky that violations get a transformer from the ContextualRuleSet
    #   of the class of the instance to which they apply (too much coupling).
    #   I'm currently leaning towards Violations looking up a transformer from
    #   the Rule that produced them.
    #   That said, I don't know if it's better for a Violation to look up its
    #   transformer from their Rule, or from the instance they are attached to.
    #
    attr_accessor :transformer

    # Mapping of context names to RuleSet instances
    #
    # @return [Hash]
    #
    # @api private
    attr_reader :rule_sets

    def_delegators :rule_sets, :each, :empty?

    # Clear all named context rule sets
    #
    # @api public
    def_delegators :rule_sets, :clear

    def initialize
      @rule_sets = Hash.new
      define_context(default_context_name)
    end

    # Delegate #validate to the appropriate RuleSet
    # 
    # @return [ViolationSet]
    #   the collection of Violations applicable to the given resource
    #
    # @api public
    def validate(resource, context_name)
      context(context_name).validate(resource)
    end

    # Return the RuleSet for a given context name
    #
    # @param [Symbol] context_name
    #   Context name for which to return a RuleSet
    #
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
    #   list of Rules applicable to +attribute_name+ in the default context
    #
    # @api public
    def [](attribute_name)
      context(default_context_name).fetch(attribute_name, [])
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
    #    {:maximum=>50, :allow_nil=>true}
    #
    # @option [Symbol] :context, :group, :when, :on
    #   the context in which the new rule should be run
    #
    # @return [self]
    #
    # @api private
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
    #
    # @api private
    def concat(other)
      other.rule_sets.each do |context_name, rule_set|
        add_rules_to_context(context_name, rule_set)
      end

      self
    end

  private

    def default_context_name
      :default
    end

    # Initialize and assign a RuleSet for the named context
    #
    # @param [Symbol] context_name
    #   the name of the context to be defined. noop if already defined
    #
    # @return [self]
    #
    # @api private
    def define_context(context_name)
      rule_sets.fetch(context_name) do |context_name|
        rule_sets[context_name] = RuleSet.new
      end

      self
    end

    def context_defined?(context_name)
      rule_sets.include?(context_name)
    end

    # Define a context and append rules to it
    #
    # @param [Symbol] context_name
    #   name of the context to define and append rules to
    # @param [RuleSet, Array] rules
    #   Rules to append to +context_name+
    #
    # @return [self]
    #
    # @api private
    def add_rules_to_context(context_name, rules)
      define_context(context_name)
      context(context_name).concat(rules)

      self
    end

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
      context_name = options.values_at(:context, :group, :when, :on).compact.first
      Array(context_name || default_context_name)
    end

  end # class ContextualRuleSet
end # module Aequitas
