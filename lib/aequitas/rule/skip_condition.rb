# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    class SkipCondition
      extend ValueObject

      equalize_on :allow_nil, :allow_blank

      attr_reader :allow_nil
      attr_reader :allow_blank

      def self.extract(options, name)
        !!options[name] if options.include?(name)
      end

      def initialize(options = {})
        @allow_nil   = self.class.extract(options, :allow_nil)
        @allow_blank = self.class.extract(options, :allow_blank)
      end

      # Test a value to determine if it should be skipped,
      #   according to the receiver's configuration
      # 
      # @param [#nil?] value
      #   the value to be tested
      # 
      # @return [Boolean]
      def skip?(value)
        if value.nil?
          @allow_nil.nil? ? allow_blank? : allow_nil?
        elsif Aequitas.blank?(value)
          allow_blank?
        else
          false
        end
      end

      # Inquire whether the receiver is configured to allow nil values
      # 
      # @return [Boolean]
      def allow_nil?
        @allow_nil.nil? ? false : @allow_nil
      end

      # Inquire whether the receiver is configured to allow blank values
      # 
      # @return [Boolean]
      def allow_blank?
        @allow_blank.nil? ? false : @allow_blank
      end

      # Set the receiver to allow nil values
      # 
      # @return [self]
      def allow_nil!
        @allow_nil = true
        self
      end

      # Set the receiver to allow blank values
      # 
      # @return [self]
      def allow_blank!
        @allow_blank = true
        self
      end

      # Set the receiver to reject nil values
      # 
      # @return [self]
      def reject_nil!
        @allow_nil = false
        self
      end

      # Set the receiver to reject blank values
      # 
      # @return [self]
      def reject_blank!
        @allow_blank = false
        self
      end

      # Set the receiver to allow nil values
      #   if a value has not already been set
      # 
      # @return [self]
      def default_to_allowing_nil!
        allow_nil! if allow_nil.nil?
        self
      end

      # Set the receiver to allow blank values
      #   if a value has not already been set
      # 
      # @return [self]
      def default_to_allowing_blank!
        allow_blank! if allow_blank.nil?
        self
      end

    end # class SkipCondition
  end # class Rule
end # module Aequitas
