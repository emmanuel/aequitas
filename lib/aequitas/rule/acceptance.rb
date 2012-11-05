# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    # TODO: update this to inherit from Rule::Inclusion::Set
    class Acceptance < Rule

      equalize(:accept)

      DEFAULT_ACCEPTED_VALUES = [ '1', 1, 'true', true, 't' ]

      attr_reader :accept

      def initialize(attribute_name, options = {})
        unless options.key?(:allow_nil)
          options[:allow_nil]=true
        end
        super

        @accept = Array(options.fetch(:accept, DEFAULT_ACCEPTED_VALUES)).to_set
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
