# -*- encoding: utf-8 -*-

require 'aequitas/blank'
require 'aequitas/equalizable'

module Aequitas
  class Rule
    class SkipCondition
      extend Equalizable

      equalize_on [:allow_nil, :allow_blank]

      attr_reader :allow_nil
      attr_reader :allow_blank

      def initialize(options = {})
        @allow_nil   = !!options[:allow_nil]   if options.include?(:allow_nil)
        @allow_blank = !!options[:allow_blank] if options.include?(:allow_blank)
      end

      def skip?(value)
        if value.nil?
          @allow_nil.nil? ? allow_blank? : allow_nil?
        elsif Aequitas.blank?(value)
          allow_blank?
        else
          false
        end
      end

      def allow_nil?
        @allow_nil.nil? ? false : @allow_nil
      end

      def allow_blank?
        @allow_blank.nil? ? false : @allow_blank
      end

      def allow_nil!
        @allow_nil = true
      end

      def allow_blank!
        @allow_blank = true
      end

      def reject_nil!
        @allow_nil = false
      end

      def reject_blank!
        @allow_blank = false
      end

      def default_to_allowing_nil!
        allow_nil! if @allow_nil.nil?
      end

      def default_to_allowing_blank!
        allow_blank! if @allow_blank.nil?
      end

    end # class SkipCondition
  end # class Rule
end # module Aequitas
