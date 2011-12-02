# -*- encoding: utf-8 -*-

require 'aequitas/rule/within'

module Aequitas
  class Rule
    module Within
      class Set < Rule

        equalize_on *(superclass.equalizer.keys + [:set])

        include Within

        attr_reader :set

        def initialize(attribute_name, options={})
          super

          @set = options.fetch(:set, [])
        end

        def valid?(resource)
          value = attribute_value(resource)

          skip?(value) || set.include?(value)
        end

        def violation_type(resource)
          :inclusion
        end

        def violation_data(resource)
          [ [ :set, set.to_a.join(', ') ] ]
        end

      end # class Set
    end # module Within
  end # class Rule
end # module Aequitas
