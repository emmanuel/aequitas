# -*- encoding: utf-8 -*-

module Aequitas
  class ViolationSet

    include Adamantium::Flat, Enumerable

    # Return violations
    #
    # @return [Enumerable<Violations>]
    #
    # @api private
    #
    attr_reader :violations

    # Initialize object
    #
    # @param [Enumerable<Violations>] violations
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(violations = [])
      @violations = violations
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
    def on(attribute_name)
      violations.select { |violation| violation.attribute_name == attribute_name }
    end

    # Return attribute names with at least one violation
    #
    # @return [Enumerable<Symbol>]
    # 
    # @api public
    # 
    def attribute_names
      violations.each_with_object(Set.new) do |violation, names|
        names << violation.attribute_name
      end
    end
    memoize :attribute_names

    # Enumerate violations
    #
    # @return [self]
    #   if block given
    #
    # @return [Enumerator<Violation]
    #   otherwise
    #
    # @api public
    #
    def each
      return to_enum unless block_given?

      attribute_names.each do |name|
        yield on(name)
      end

      self
    end

    # Return amount of violations
    #
    # @return [Fixnum]
    #
    # @api public
    #
    def size
      violations.size
    end

    # Test if any violation is present
    #
    # @return [true]
    #   if there is at least one violation
    #
    # @return [false]
    #   otherwise
    #
    # @api private
    #
    def empty?
      violations.empty?
    end

  end # class ViolationSet
end # module Aequitas
