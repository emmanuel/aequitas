# -*- encoding: utf-8 -*-

require 'aequitas/rule'

module Aequitas
  class Rule
    class Method < Rule

      equalize_on *(superclass.equalizer.keys + [:method])

      attr_reader :method

      def initialize(attribute_name, options={})
        super

        @method = options.fetch(:method, attribute_name)
      end

      def validate(resource)
        result, error_message = resource.__send__(method)

        if result
          nil
        else
          Violation.new(resource, error_message, self)
        end
      end

    end # class Method
  end # class Rule
end # module Aequitas
