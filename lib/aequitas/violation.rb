# -*- encoding: utf-8 -*-

module Aequitas
  class Violation
    extend Aequitas::ValueObject

    equalize_on :resource, :rule, :custom_message, :attribute_name

    # Return object validated in this violation
    #
    # @return [Object]
    # 
    # @api private
    #
    attr_reader :resource

    # Return custom message for this validation
    #
    # @return [String, #call]
    #   custom message returned by #message and #to_s
    #
    # @api private
    #
    attr_reader :custom_message

    # Rule which generated this Violation
    #
    # @return [Aequitas::Rule, nil]
    #   validaiton rule that triggered this violation if present
    #
    # @return [nil]
    #   otherwise
    # 
    # @api private
    #
    attr_reader :rule

    # Initialize object
    # 
    # @param [Object] resource
    #   the validated object
    #
    # @param [String, #call, Hash] message
    #   an optional custom message for this Violation
    #
    # @param [Hash] options
    #   for configuring concrete subclasses
    #
    # @return [undefined]
    #
    # @api public
    #
    def initialize(resource, message = nil, options = {})
      @resource       = resource
      @custom_message = message
    end

    # Return message 
    #
    # @param [MessageTransformer] transformer
    #   option messagetransfomer
    #
    # @return [String]
    #
    # @api private
    #
    def message(transformer = Undefined)
      return @custom_message if @custom_message

      transformer = Aequitas.default_transformer if Undefined.equal?(transformer)

      transformer.transform(self)
    end

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
