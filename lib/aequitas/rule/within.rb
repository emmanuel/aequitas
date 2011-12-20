# -*- encoding: utf-8 -*-

require 'aequitas/rule'

module Aequitas
  class Rule
    class Within < Rule

      # TODO: move options normalization into the validator macros
      def self.rules_for(attribute_name, options)
        if options[:set].is_a?(::Range)
          Within::Range.rules_for(attribute_name, options)
        else
          Array(Within::Set.new(attribute_name, options))
        end
      end

      def valid?(resource)
        value = attribute_value(resource)

        skip?(value) || within?(value)
      end

    end # class Within
  end # class Rule
end # module Aequitas

require 'aequitas/rule/within/range'
require 'aequitas/rule/within/set'
