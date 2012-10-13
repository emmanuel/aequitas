# -*- encoding: utf-8 -*-

module Aequitas

  # A set of rules
  class RuleSet
    # Holds a collection of Rule instances to be run against

    extend ValueObject
    extend Forwardable
    include Enumerable

    equalize_on :rules

    # @api public
    def_delegators :attribute_index, :[], :fetch

    # @api public
    def_delegators :rules, :each, :empty?

    # Return rules
    #
    # @return [Enumerable<Rule>]
    #
    # @api public
    #
    attr_reader :rules

    # Return attribute index
    #
    # @return [Hash]
    #
    # @api private
    #
    attr_reader :attribute_index

    # Initialize object
    #
    # @return [undefined]
    # 
    # @api private
    #
    def initialize
      @rules           = Set.new
      @attribute_index = Hash.new { |h,k| h[k] = [] }
    end

    # Append rule
    #
    # @param [Rule]
    #
    # @return [self]
    #
    # @api private
    #
    def <<(rule)
      unless rules.include?(rule)
        rules << rule
        attribute_index[rule.attribute_name] << rule
      end

      self
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
    # @return [self]
    #
    # @api private
    # 
    # TODO: push responsibility for the array of attribute_names out to methods
    #   in Aequitas::Macros.
    #
    def add(rule_class, attribute_names, options = {}, &block)

      attribute_names.each do |attribute_name|
        rules = rule_class.rules_for(attribute_name, options, &block)

        concat(rules)
      end

      self
    end

    # Execute all rules against the resource.
    # 
    # @param [Object] resource
    #   the resource to be validated
    # 
    # @return [Array(Violation)]
    #   an Array of Violations
    #
    # @api private
    #
    def validate(resource)
      rules = rules_for_resource(resource)
      rules.map { |rule| rule.validate(resource) }.compact
      # TODO:
      #   violations = rules.map { |rule| rule.validate(resource) }.compact
      #   ViolationSet.new(resource).concat(violations)
    end

    # Assimilate all the rules from another RuleSet into the receiver
    # 
    # @param [RuleSet, Array] rules
    #   The other RuleSet (or Array) whose rules are to be assimilated
    # 
    # @return [self]
    #
    # @api private
    #
    def concat(rules)
      rules.each { |rule| self << rule.dup }

      self
    end

    # Return inspection string
    #
    # @return [String]
    #
    # @api private
    #
    def inspect
      "#<#{ self.class } {#{ rules.map { |e| e.inspect }.join( ', ' ) }}>"
    end

    # Return rules for resource
    #
    # @param [Object] resource
    #
    # @api private
    #
    def rules_for_resource(resource)
      rules.select { |r| r.execute?(resource) }
    end

  end # class RuleSet
end # module Aequitas
