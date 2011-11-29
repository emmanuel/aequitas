# -*- encoding: utf-8 -*-

require 'aequitas/rule/length'

module Aequitas
  class Rule
    module Length
      class Minimum < Rule

        include Length

        attr_reader :bound

        def initialize(attribute_name, options)
          super

          @bound = options.fetch(:bound)
        end

        def violation_type(resource)
          :too_short
        end

        def violation_data(resource)
          [ [ :minimum, bound ] ]
        end

      private

        # Validate the value length is greater than or equal to the bound
        #
        # @param [Integer] length
        #   the value length
        #
        # @return [String, NilClass]
        #   the error message if invalid, nil if valid
        #
        # @api private
        def valid_length?(length)
          bound <= length
        end

      end # class Minimum
    end # module Length
  end # class Rule
end # module Aequitas
