# -*- encoding: utf-8 -*-

module Aequitas
  class Violation
    extend ValueObject
    include Adamantium
    
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

  private

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
    # @api private
    #
    def initialize(resource, message = nil, options = {})
      @resource       = resource
      @custom_message = message
    end

  end # class Violation
end # module Aequitas
