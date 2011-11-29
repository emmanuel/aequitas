# -*- encoding: utf-8 -*-

require 'aequitas/rule/length'

module Aequitas
  class Rule
    module Length
      class Minimum < Rule

        include Length

        attr_reader :expected

        def initialize(attribute_name, options)
          super

          @expected = options.fetch(:bound)
        end

        def violation_type(resource)
          :too_short
        end

        def violation_data(resource)
          [ [ :minimum, expected ] ]
        end

      private

        # Validate the minimum expected value length
        #
        # @param [Integer] length
        #   the value length
        #
        # @return [String, NilClass]
        #   the error message if invalid, nil if valid
        #
        # @api private
        def valid_length?(length)
          expected <= length
        end

      end # class Minimum
    end # module Length
  end # class Rule
end # module Aequitas
