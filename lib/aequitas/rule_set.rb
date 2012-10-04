# -*- encoding: utf-8 -*-

module Aequitas
  class RuleSet
    # Holds a collection of Rule instances to be run against
    # Resources to validate the Resources in a specific context

    extend ValueObject
    extend Forwardable
    include Enumerable

    equalize_on :rules

    # @api public
    def_delegators :attribute_index, :[], :fetch

    # @api public
    def_delegators :rules, :each, :empty?

    # @api public
    attr_reader :rules

    # @api private
    attr_reader :attribute_index

    def initialize
      @rules           = Set.new
      @attribute_index = Hash.new { |h,k| h[k] = [] }
    end

    def <<(rule)
      unless rules.include?(rule)
        rules << rule
        attribute_index[rule.attribute_name] << rule
      end

      self
    end

    # Execute all rules in this context against the resource.
    # 
    # @param [Object] resource
    #   the resource to be validated
    # 
    # @return [Array(Violation)]
    #   an Array of Violations
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
    def concat(rules)
      rules.each { |rule| self << rule.dup }

      self
    end

    def inspect
      "#<#{ self.class } {#{ rules.map { |e| e.inspect }.join( ', ' ) }}>"
    end

    def rules_for_resource(resource)
      rules.select { |r| r.execute?(resource) }
    end

  end # class RuleSet
end # module Aequitas
