# -*- encoding: utf-8 -*-

require 'aequitas/exceptions'
require 'aequitas/support/value_object'
require 'aequitas/message_transformer'

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
    # @return [Aequitas::Rule]
    #   validaiton rule that triggered this violation
    # 
    # @api public
    attr_reader :rule

    # Name of the attribute which this Violation pertains to
    #
    # @return [Symbol]
    #   the name of the validated attribute associated with this violation
    #
    # @api public
    attr_reader :attribute_name


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
      @custom_message = evaluate_message(message)
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
      if resource.respond_to?(:validation_rules) && transformer = resource.validation_rules.transformer
        transformer
      else
        Violation.default_transformer
      end
    end

    # TODO: Drop this or heavily refactor it.
    #   This is too complicated and coupled to DM.
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

require 'aequitas/violation/rule'
require 'aequitas/violation/message'
