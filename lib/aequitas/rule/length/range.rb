# -*- encoding: utf-8 -*-

require 'aequitas/rule/length'

module Aequitas
  class Rule
    module Length
      class Range < Rule

        include Length

        attr_reader :range

        def initialize(attribute_name, options)
          super

          @range = options.fetch(:range)
        end

        def violation_type(resource)
          :length_between
        end

        def violation_data(resource)
          [ [ :min, range.begin ], [ :max, range.end ] ]
        end

      private

        # Validate the value length is within expected range
        #
        # @param [Integer] length
        #   the value length
        #
        # @return [String, NilClass]
        #   the error message if invalid, nil if valid
        #
        # @api private
        def valid_length?(length)
          range.include?(length)
        end

      end # class Range
    end # module Length
  end # class Rule
end # module Aequitas
