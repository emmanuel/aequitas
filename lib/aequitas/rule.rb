# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    extend ValueObject

    equalize_on :attribute_name, :custom_message, :guard, :skip_condition

    # Return attribute name
    #
    # @return [Symbol]
    #
    # @api private
    #
    attr_reader :attribute_name

    # Return custom message
    #
    # @return [String]
    #
    # @api private
    #
    attr_reader :custom_message

    # Return guard
    #
    # @return [Guard]
    #
    # @api private
    #
    attr_reader :guard

    # Return guard
    #
    # @return [SkipCondition]
    #
    # @api private
    #
    attr_reader :skip_condition

    # Get the validators for the given attribute_name and options
    # 
    # @param [Symbol] attribute_name
    #   the name of the attribute to which the returned validators will be bound
    # @param [Hash] options
    #   the options with which to configure the returned validators
    # 
    # @return [#each(Rule)]
    #   a collection of validators which collectively
    # 
    def self.rules_for(attribute_name, options, &block)
      Array(new(attribute_name, options, &block))
    end

    # Initialize a rule. Capture the :if and :unless clauses when
    # present.
    #
    # @param [String, Symbol] attribute_name
    #   The name of the attribute to validate.
    #
    # TODO: remove Hash as a value for :message
    #   (see Violation#[] in backwards.rb)
    # 
    # @option [String, Hash] :message
    #   A custom message that will be used for any violations of this rule
    # @option [Symbol, Proc] :if
    #   The name of a method (on the valiated resource) or a Proc to call
    #   (with the resource) to determine if the rule should be applied.
    # @option [Symbol, Proc] :unless
    #   The name of a method (on the valiated resource) or a Proc to call
    #   (with the resource) to determine if the rule should *not* be applied.
    # @option [Boolean] :allow_nil
    #   Whether to skip applying this rule on nil values
    # @option [Boolean] :allow_blank
    #   Whether to skip applying this rule on blank values
    def initialize(attribute_name, options = {})
      @attribute_name = attribute_name
      @custom_message = options.fetch(:message, nil)
      @guard          = options.fetch(:guard)          { Guard.new(options) }
      @skip_condition = options.fetch(:skip_condition) { SkipCondition.new(options) }
    end

    # Validate the +resource+ arg against this Rule
    # 
    # @param [Object] resource
    #   the target object to be validated
    # 
    # @return [nil]
    #   if +resource+ is valid
    #
    # @return [Violation]
    #   otherwise
    #
    # @api private
    #
    def validate(resource)
      value = attribute_value(resource)

      if skip?(value) || valid_value?(value)
        nil
      else
        new_violation(resource, value)
      end
    end

    # Test if rule should run on resource
    #
    # @return [true]
    #   if rule should be executed on resource
    #
    # @return [false]
    #   otherwise
    #
    # @api private
    #
    def execute?(resource)
      guard.allow?(resource)
    end

    # Test if rule is skipped on value
    #
    # @param [Object] value
    #   the value to test
    #
    # @return [true]
    #   if value should be skipped
    #
    # @return [false]
    #   otherwise
    #
    # @api private
    #
    def skip?(value)
      skip_condition.skip?(value)
    end

    # Return attribute value to execute on rule
    #
    # @param [Object] resource
    #
    # @return [Object]
    #
    # @api private
    # 
    def attribute_value(resource)
      resource.validation_attribute_value(attribute_name)
    end

    # @api private
    def violation_info
      Hash[ violation_data ]
    end

    # @api private
    def violation_values
      violation_data.map { |(_, value)| value }
    end

    # @api private
    def violation_data
      [ ]
    end

  private

    def new_violation(resource, value = nil)
      Violation::Rule.new(resource, custom_message,
        :rule  => self,
        :value => value)
    end

    def assert_kind_of(name, value, *klasses)
      klasses.each { |k| return if value.kind_of?(k) }
      raise ArgumentError, "+#{name}+ should be #{klasses.map { |k| k.name } * ' or '}, but was #{value.class.name}", caller(2)
    end

  end # class Rule
end # module Aequitas
