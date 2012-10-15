module Aequitas
  # Mixin to define external validators
  module Validator

    module InstanceMethods

      # Return validated object
      #
      # @return [Object]
      #
      # @api private
      #
      attr_reader :object

      # Return violation set
      #
      # @return [ViolationSet]
      #
      # @api private
      #
      attr_reader :violations

      # Test if validator is valid
      #
      # @return [true]
      #   if valid
      #
      # @return [false]
      #   otherwise
      #
      def valid?
        violations.empty?
      end

      # Return validation rules
      #
      # @return [RuleSet]
      # 
      # @api private
      #
      def rules
        self.class.validation_rules
      end

      # Retrieve the value of the given property name for the purpose of validation
      #
      # Defaults to sending the attribute name arg to the receiver and
      # using the resulting value as the attribute value for validation
      #
      # @param [Symbol] attribute_name
      #   the name of the attribute for which to retrieve
      #   the attribute value for validation.
      #
      # @return [Object]
      #   the value of the attribute identified by +attribute_name+
      #   for the purpose of validation
      #
      # @api public
      #
      def validation_attribute_value(attribute_name)
        object.__send__(attribute_name) if object.respond_to?(attribute_name, true)
      end

    private

      # Initialize object
      #
      # @param [Object] object
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(object)
        @object = object
        @violations = ViolationSet.new(rules.validate(self).each.to_a)
      end

    end

    # Hook called when module is included
    #
    # @param [Class|Module] descendant
    #
    # @return [undefined]
    #
    # @api private
    #
    def self.included(descendant)
      super
      descendant.class_eval do
        include ::Adamantium
        include InstanceMethods
      end
      descendant.extend(ClassMethods)
    end

  end
end
