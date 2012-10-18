# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    class Inclusion < Rule

      equalize_on *superclass.equalizer.keys + [:within]

      attr_reader :within

      def initialize(attribute_name, options={})
        super

        @set = options.fetch(:within)
      end

      def valid_value?(value)
        skip?(value) || set.include?(value)
      end

      def violation_type
        :inclusion
      end

      # TODO: is it worth converting to a String (dumping this information)?
      def violation_data
        [ [ :within, set.to_a.join(', ') ] ]
      end

    end # class Within
  end # class Rule
end # module Aequitas
