# -*- encoding: utf-8 -*-

require 'aequitas/rule/within'

module Aequitas
  class Rule
    class Within
      class Range < Within

        equalize_on *superclass.superclass.equalizer.keys + [:range]

        Infinity = 1.0 / 0

        attr_reader :range

        def self.rules_for(attribute_name, options)
          range = options.fetch(:range) { options.fetch(:set) }

          rule =
            if range.first != -Infinity && range.last != Infinity
              Bounded.new(attribute_name, options)
            elsif range.first == -Infinity
              UnboundedBegin.new(attribute_name, options)
            elsif range.last == Infinity
              UnboundedEnd.new(attribute_name, options)
            end

            Array(rule)
        end

        def initialize(attribute_name, options={})
          super

          @range = options.fetch(:range) { options.fetch(:set) }
        end

        def within?(value)
          range.include?(value)
        end

      end # class Range
    end # class Within
  end # class Rule
end # module Aequitas

require 'aequitas/rule/within/range/bounded'
require 'aequitas/rule/within/range/unbounded_begin'
require 'aequitas/rule/within/range/unbounded_end'
