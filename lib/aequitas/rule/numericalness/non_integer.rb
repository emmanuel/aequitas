# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    class Numericalness
      class NonInteger < Numericalness

        attr_reader :precision
        attr_reader :scale

        def initialize(attribute_name, options)
          super

          @precision = options.fetch(:precision, nil)
          @scale     = options.fetch(:scale,     nil)

          unless expected # validate precision and scale attrs
            raise ArgumentError, "Invalid precision #{precision.inspect} and scale #{scale.inspect} for #{attribute_name}"
          end
        end

        def expected(precision = @precision, scale = @scale)
          if precision && scale
            if precision > scale && scale == 0
              /\A[+-]?(?:\d{1,#{precision}}(?:\.0)?)\z/
            elsif precision > scale
              delta = precision - scale
              /\A[+-]?(?:\d{1,#{delta}}|\d{0,#{delta}}\.\d{1,#{scale}})\z/
            elsif precision == scale
              /\A[+-]?(?:0(?:\.\d{1,#{scale}})?)\z/
            else
              nil
            end
          else
            /\A[+-]?(?:\d+|\d*\.\d+)\z/
          end
        end

        def violation_type
          :not_a_number
        end

      end # class NonInteger
    end # module Numericalness
  end # class Rule
end # module Aequitas
