# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    class SkipCondition
      include Equalizer.new(:allow_nil, :allow_blank)

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

    end # class SkipCondition
  end # class Rule
end # module Aequitas
