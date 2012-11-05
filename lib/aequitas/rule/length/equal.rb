# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    class Length
      class Equal < Length

        equalize(:expected)

        attr_reader :expected

        def initialize(attribute_name, options)
          super

          @expected = options.fetch(:expected)
        end

        def violation_type
          :wrong_length
        end

        def violation_data
          [ [ :expected, expected ] ]
        end

        # Validate the value length is equal to the expected length
        #
        # @param [Integer] length
        #   the value length
        #
        # @return [String, nil]
        #   the error message if invalid, nil if not
        #
        # @api private
        def expected_length?(length)
          expected == length
        end

      end # class Equal
    end # class Length
  end # class Rule
end # module Aequitas
