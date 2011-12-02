# -*- encoding: utf-8 -*-

require 'aequitas/support/equalizable'

module Aequitas
  class Rule
    class Guard
      extend Equalizable

      equalize_on :if_test, :unless_test

      attr_reader :if_test
      attr_reader :unless_test

      def initialize(options = {})
        @if_test     = options.fetch(:if,     nil)
        @unless_test = options.fetch(:unless, nil)
      end

      # Determines if this RuleGuard allows the given resource
      # by evaluating the if_test and unless_test
      #
      # @param [Object] resource
      #   The resource that we check against.
      #
      # @return [Boolean]
      #   true if allowed, otherwise false.
      #
      # @api private
      def allow?(resource)
        if if_test
          !!evaluate_conditional_clause(resource, if_test)
        elsif unless_test
          !evaluate_conditional_clause(resource, unless_test)
        else
          true
        end
      end

      # @api private
      def evaluate_conditional_clause(resource, clause)
        if clause.respond_to?(:call)
          clause.call(resource)
        elsif clause.kind_of?(Symbol)
          resource.__send__(clause)
        end
      end

    end # class Guard
  end # class Rule
end # module Aequitas
