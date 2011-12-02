# -*- encoding: utf-8 -*-

require 'aequitas/exceptions'
require 'aequitas/support/equalizable'
require 'aequitas/message_transformer'

module Aequitas
  class Violation
    extend Aequitas::Equalizable

    equalize_on :resource, :rule, :custom_message, :attribute_name

    def self.default_transformer
      @default_transformer ||= MessageTransformer.default
    end

    def self.default_transformer=(transformer)
      @default_transformer = transformer
    end

    attr_reader :resource
    attr_reader :custom_message
    attr_reader :rule
    attr_reader :attribute_name

    # Configure a Violation instance
    # 
    # @param [Object] resource
    #   the validated object
    # @param [String, #call, Hash] message
    #   an optional custom message for this Violation
    # @param [Rule] rule
    #   the Rule whose violation triggered the creation of the receiver
    # @param [Symbol] attribute_name
    #   the name of the attribute whose validation rule was violated
    #   or nil, if a Rule was provided.
    # 
    def initialize(resource, message = nil, rule = nil, attribute_name = nil)
      unless message || rule
        raise ArgumentError, "expected +message+ or +rule+"
      end

      @resource       = resource
      @rule           = rule
      @attribute_name = attribute_name
      @custom_message = evaluate_message(message)
    end

    # @api public
    def message(transformer = Undefined)
      return @custom_message if @custom_message

      transformer = Undefined == transformer ? self.transformer : transformer

      transformer.transform(self)
    end

    # @api public
    alias_method :to_s, :message

    # @api public
    def attribute_name
      if @attribute_name
        @attribute_name
      elsif rule
        rule.attribute_name
      end
    end

    # @api public
    def type
      rule ? rule.violation_type(resource) : nil
    end

    # @api public
    def info
      rule ? rule.violation_info(resource) : { }
    end

    def values
      rule ? rule.violation_values(resource) : [ ]
    end

    def transformer
      if resource.respond_to?(:validation_rules) && transformer = resource.validation_rules.transformer
        transformer
      else
        Violation.default_transformer
      end
    end

    def evaluate_message(message)
      if message.respond_to?(:call)
        if resource.respond_to?(:model) && resource.model.respond_to?(:properties)
          property = resource.model.properties[attribute_name]
          message.call(resource, property)
        else
          message.call(resource)
        end
      else
        message
      end
    end

    # In general we want Aequitas::Equalizable-type equality/equivalence,
    # but this allows direct equivalency test against Strings, which is handy
    def ==(other)
      if other.respond_to?(:to_str)
        self.to_s == other.to_str
      else
        super
      end
    end

  end # class Violation
end # module Aequitas
