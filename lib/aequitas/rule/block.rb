# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    class Block < Rule

      attr_reader :block, :violation_type

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
          new_violation(resource)
        end
      end

    end # class Block
  end # class Rule
end # module Aequitas
