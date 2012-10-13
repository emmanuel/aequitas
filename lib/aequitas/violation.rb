# -*- encoding: utf-8 -*-

module Aequitas
  class Violation
    extend Aequitas::ValueObject

    equalize_on :resource, :rule, :custom_message, :attribute_name

    def self.default_transformer
      @default_transformer ||= MessageTransformer.default
    end

    def self.default_transformer=(transformer)
      @default_transformer = transformer
    end

    # Object that triggered this Violation
    #
    # @return [Object]
    #   object which triggered this violation
    # 
    # @api public
    attr_reader :resource

    # Custom message for this Violation
    #
    # @return [String, #call]
    #   custom message returned by #message and #to_s
    #
    # @api public
    attr_reader :custom_message

    # Rule which generated this Violation
    #
    # @return [Aequitas::Rule, nil]
    #   validaiton rule that triggered this violation
    #   or nil, if called on a Violation type that doesn't need a rule
    # 
    # @api public
    attr_reader :rule

    # Configure a Violation instance
    # 
    # @param [Object] resource
    #   the validated object
    # @param [String, #call, Hash] message
    #   an optional custom message for this Violation
    # @param [Hash] options
    #   options hash for configuring concrete subclasses
    #
    # @api public
    def initialize(resource, message, options = {})
      @resource       = resource
      @custom_message = message
    end

    # @api public
    def message(transformer = Undefined)
      return @custom_message if @custom_message

      transformer = self.transformer if Undefined.equal?(transformer)

      transformer.transform(self)
    end

    # @api public
    alias_method :to_s, :message

    # @api public
    def type
      raise NotImplementedError, "#{self.class}#type is not implemented"
    end

    # @api public
    def info
      raise NotImplementedError, "#{self.class}#info is not implemented"
    end

    # @api public
    def values
      raise NotImplementedError, "#{self.class}#values is not implemented"
    end

    # @api private
    def transformer
      Violation.default_transformer
    end

    # In general we want Aequitas::ValueObject-type equality/equivalence,
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
