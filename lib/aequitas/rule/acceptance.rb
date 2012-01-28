# -*- encoding: utf-8 -*-

require 'set'
require 'aequitas/rule'

module Aequitas
  class Rule
    # TODO: update this to inherit from Rule::Within::Set
    class Acceptance < Rule

      equalize_on *(superclass.equalizer.keys + [:accept])

      DEFAULT_ACCEPTED_VALUES = [ '1', 1, 'true', true, 't' ]

      attr_reader :accept

      def initialize(attribute_name, options = {})
        super

        @accept = Array(options.fetch(:accept, DEFAULT_ACCEPTED_VALUES)).to_set

        skip_condition.default_to_allowing_nil!
      end

      def valid_value?(value)
        skip?(value) || accept.include?(value)
      end

      def violation_type
        :accepted
      end

    end # class Acceptance
  end # class Rule
end # module Aequitas
