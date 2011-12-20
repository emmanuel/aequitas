# -*- encoding: utf-8 -*-

require 'aequitas/rule'

module Aequitas
  class Rule
    class Within < Rule

      # TODO: move options normalization into the validator macros
      def self.rules_for(attribute_name, options)
        Array(new(attribute_name, options))
      end

      equalize_on *superclass.equalizer.keys + [:set]

      attr_reader :set

      def initialize(attribute_name, options={})
        super

        @set = options.fetch(:set)
      end

      def valid?(resource)
        value = attribute_value(resource)

        skip?(value) || set.include?(value)
      end

      def violation_type(resource)
        :inclusion
      end

      def violation_data(resource)
        [ [ :set, set.to_a.join(', ') ] ]
      end

    end # class Within
  end # class Rule
end # module Aequitas
