# -*- encoding: utf-8 -*-

module Aequitas
  class ViolationSet

    include Enumerable, Adamantium::Flat

    # Return violations
    #
    # @return [Enumerable<Violations>]
    #
    # @api private
    #
    attr_reader :violations
    private :violations

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
    # TODO: use a data structure that ensures uniqueness
    #
    def on(attribute_name)
      violations.select { |violation| violation.attribute_name == attribute_name }.uniq
    end

    # FIXME: Inneficient workaround to keep api stable while refactoring
    #
    # @api public
    def each
      violations.map(&:attribute_name).uniq.each do |name|
        yield on(name)
      end
    end

    # FIXME: Remove array like interfaces
    def size
      violations.size
    end

    # @api public
    def empty?
      violations.empty?
    end

  end # class ViolationSet
end # module Aequitas
