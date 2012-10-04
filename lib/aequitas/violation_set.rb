# -*- encoding: utf-8 -*-

module Aequitas
  class ViolationSet

    include Enumerable

    # @api private
    attr_reader :resource

    # @api private
    attr_reader :violations
    # TODO: why was this private?
    private :violations

    # TODO: replace OrderedHash with OrderedSet and remove vendor'd OrderedHash
    def initialize(resource)
      @resource   = resource
      @violations = OrderedHash.new { |h,k| h[k] = [] }
    end

    # Clear existing validation violations.
    # 
    # @api public
    def clear
      violations.clear
    end

    # Add a validation error. Use the attribute_name :general if the violations
    # does not apply to a specific field of the Resource.
    #
    # @param [Symbol, Violation] attribute_name_or_violation
    #   The name of the field that caused the violation, or
    #   the Violation which describes the validation violation
    # @param [NilClass, String, #call, Hash] message
    #   The message to add.
    # 
    # @see Violation#initialize
    # 
    # @api public
    def add(attribute_name_or_violation, message = nil)
      violation = 
        if attribute_name_or_violation.kind_of?(Violation)
          attribute_name_or_violation
        else
          Violation::Message.new(resource, message, :attribute_name => attribute_name_or_violation)
        end

      self << violation
    end

    def <<(violation)
      violations[violation.attribute_name] << violation
      self
    end

    def concat(other)
      other.each { |violation| self << violation }
    end

    # Collect all violations into a single list.
    # 
    # @api public
    def full_messages
      violations.inject([]) do |list, (attribute_name, violations)|
        messages = violations
        messages = violations.full_messages if violations.respond_to?(:full_messages)
        list.concat(messages)
      end
    end

    # Return validation violations for a particular attribute_name.
    #
    # @param [Symbol] attribute_name
    #   The name of the field you want an violation for.
    #
    # @return [Array(Violation, String)]
    #   Array of Violations, if there are violations on +attribute_name+
    #   nil if there are no violations on +attribute_name+
    # 
    # @api public
    # 
    # TODO: use a data structure that ensures uniqueness
    def on(attribute_name)
      violations[attribute_name].uniq
    end

    # @api public
    def each
      violations.each_value do |v|
        yield(v) unless Aequitas.blank?(v)
      end
    end

    # @api public
    def empty?
      violations.all? { |_, violations| violations.empty? }
    end

    # @api public
    # 
    # FIXME: calling #to_sym on uncontrolled input is an
    # invitation for a memory leak
    def [](attribute_name)
      violations[attribute_name.to_sym]
    end

    def method_missing(meth, *args, &block)
      violations.send(meth, *args, &block)
    end

    def respond_to?(method)
      super || violations.respond_to?(method)
    end

  end # class ViolationSet
end # module Aequitas
