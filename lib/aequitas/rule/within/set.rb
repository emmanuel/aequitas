# -*- encoding: utf-8 -*-

require 'aequitas/rule/within'

module Aequitas
  class Rule
    class Within
      class Set < Within

        equalize_on *superclass.superclass.equalizer.keys + [:set]

        attr_reader :set

        def initialize(attribute_name, options={})
          super

          @set = options.fetch(:set, [])
        end

        def valid?(resource)
          value = attribute_value(resource)

          skip?(value) || within?(value)
        end

        def violation_type(resource)
          :inclusion
        end

        def violation_data(resource)
          [ [ :set, set.to_a.join(', ') ] ]
        end

        def within?(value)
          set.include?(value)
        end

      end # class Set
    end # module Within
  end # class Rule
end # module Aequitas
