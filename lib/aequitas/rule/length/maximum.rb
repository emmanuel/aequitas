# -*- encoding: utf-8 -*-

require 'aequitas/rule/length'

module Aequitas
  class Rule
    module Length
      class Maximum < Rule

        include Length

        attr_reader :bound

        def initialize(attribute_name, options)
          super

          @bound = options.fetch(:bound)
        end

        def violation_type(resource)
          :too_long
        end

        def violation_data(resource)
          [ [ :maximum, bound ] ]
        end

      private

        # Validate the value length is less than or equal to the bound
        #
        # @param [Integer] length
        #   the value length
        #
        # @return [String, NilClass]
        #   the error message if invalid, nil if valid
        #
        # @api private
        def valid_length?(length)
          bound >= length
        end

      end # class Maximum
    end # module Length
  end # class Rule
end # module Aequitas
