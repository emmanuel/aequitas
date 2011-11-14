# -*- encoding: utf-8 -*-

require 'i18n'

module Aequitas
  # Transforms Violations to error message strings.
  #
  # @abstract
  #   Subclass and override {#transform} to implement a custom message
  #   transformer. Use {Violation.message_transformer=} to set a new
  #   message transformer or pass the transformer to {Violation#message}.
  class MessageTransformer
    class Default < MessageTransformer
      # Transforms the specified Violation to an error message string.
      #
      # @param [Violation] violation
      #   The Violation to transform.
      # 
      # @return [String]
      #   The transformed message.
      #
      # @raise [ArgumentError]
      #   +violation+ is +nil+.
      def transform(violation)
        raise ArgumentError, "+violation+ must be specified" if violation.nil?

        resource       = violation.resource
        model_name     = resource.model.model_name
        attribute_name = violation.attribute_name

        options = {
          :model     => ::I18n.translate("models.#{model_name}"),
          :attribute => ::I18n.translate("attributes.#{model_name}.#{attribute_name}"),
          :value     => resource.validation_property_value(attribute_name)
        }.merge(violation.info)

        ::I18n.translate("#{i18n_namespace}.#{violation.type}", options)
      end

      attr_writer :i18n_namespace

      def i18n_namespace
        @i18n_namespace ||= 'aequitas.validation.errors'
      end

    end # class Default
  end # class MessageTransformer
end # module Aequitas
