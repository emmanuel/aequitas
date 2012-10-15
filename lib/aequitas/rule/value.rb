# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    class Value < Rule

      equalize_on *superclass.equalizer.keys + [:expected]

      # Builder for rules from options hash
      class Builder

        # Return registry of options
        #
        # @return [Hash<Class,Enumerable<Symbol>>]
        #
        # @api private
        #
        # TODO: Use registration rather than maintaining this list
        #
        def self.registry
          @registry ||= {
            Equal              => [:eq,  :equal, :equals, :equal_to, :exactly],
            NotEqual           => [:ne,  :not_equal_to],
            GreaterThan        => [:gt,  :greater_than],
            LessThan           => [:lt,  :less_than],
            GreaterThanOrEqual => [:gte, :greater_than_or_equal_to],
            LessThanOrEqual    => [:lte, :less_than_or_equal_to],
            Range              => [:in,  :within]
          }
        end

        # Run builder in attributes for options
        #
        # @param [Symbol] attribute_name
        # @param [Hash] options
        #
        # @return [Enumerable<Rule>]
        #
        # @api private
        #
        def self.run(attribute_name, options)
          registry.each_key.map do |klass|
            Rule.new(attribute_name, klass, options).rule
          end.compact
        end

        # Rule builder
        class Rule 
          include Adamantium

          # Return build rule
          #
          # @return [nil]
          #   if no option matches
          #
          # @return [Rule]
          #   if one option matches
          #
          # @raise [RuntimeError]
          #   when multiple options match
          #
          # @api private
          #
          def rule
            case values.length
            when 0
              return
            when 1
              @klass.new(@attribute_name, :expected => values.first)
            else
              raise "More than one option given for: #{@klass}"
            end
          end

        private

          # Initialize object
          #
          # @param [Symbol] attribute_name
          # @param [Class] klass
          # @param [Hash] option
          #
          # @return [undefined]
          #
          # @api private
          #
          def initialize(attribute_name, klass, options)
            @attribute_name, @klass, @options = attribute_name, klass, options
          end

          # Return keys for klass
          #
          # @return [Enumerable<Symbol>]
          #
          # @api private
          #
          def keys
            Builder.registry.fetch(@klass)
          end

          # Return captured values in options
          #
          # @return [Enumerable<Object>]
          #
          # @api private
          #
          def values
            keys.each_with_object([]) do |key, values|
              values << @options[key]
            end.compact
          end
        end
      end

      # Return rules for attribute 
      #
      # @param [Symbol] attribute_name
      #
      # @param [Options] options
      #
      # @return [Enumerable<Rule>]
      #
      # @api private
      #
      # FIXME: 
      #
      #   Refactor this with use instances of an extractor
      #
      def self.rules_for(attribute_name, options)
        Builder.run(attribute_name, options)
      end

      # Initialize object
      #
      # @param [Symbol] attribute_name
      # @param [Hash] options
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(attribute_name, options)
        super

        @expected = options.fetch(:expected)
      end

      # Return expected value
      #
      # @return [Object]
      #
      # @api private
      #
      def expected
        @expected.respond_to?(:call) ? @expected.call : @expected
      end

      def valid_value?(value)
        # TODO: is it even possible for expected to be nil?
        #   if so, return a dummy validator when expected is nil
        return true if expected.nil?

        skip?(value) || expected_value?(value)
      end

      def expected_value?(value)
        raise NotImplementedError, "#{self.class}#expected_value? is not implemented"
      end

    end # class Value
  end # class Rule
end # module Aequitas
