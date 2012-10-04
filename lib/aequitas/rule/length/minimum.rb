# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    class Length
      class Minimum < Length

        equalize_on *superclass.superclass.equalizer.keys + [:bound]

        attr_reader :bound

        def initialize(attribute_name, options)
          super

          @bound = options.fetch(:bound)
        end

        def violation_type
          :too_short
        end

        def violation_data
          [ [ :minimum, bound ] ]
        end

        # Validate the value length is greater than or equal to the bound
        #
        # @param [Integer] length
        #   the value length
        #
        # @return [String, NilClass]
        #   the error message if invalid, nil if valid
        #
        # @api private
        def expected_length?(length)
          bound <= length
        end

      end # class Minimum
    end # class Length
  end # class Rule
end # module Aequitas
