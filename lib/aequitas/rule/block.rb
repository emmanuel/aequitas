# -*- encoding: utf-8 -*-

require 'aequitas/rule'

module Aequitas
  class Rule
    class Block < Rule

      attr_reader :block

      def initialize(attribute_name, options, &block)
        unless block_given?
          raise ArgumentError, 'cannot initialize a Block validator without a block'
        end

        super

        @block = block
        @violation_type = options.fetch(:violation_type, :unsatisfied_condition)
      end

      def validate(resource)
        result, error_message = resource.instance_eval(&self.block)

        if result
          nil
        else
          Violation.new(resource, error_message, self)
        end
      end

      def violation_type(resource)
        @violation_type
      end

    end # class Block
  end # class Rule
end # module Aequitas
