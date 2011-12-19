# -*- encoding: utf-8 -*-

require 'bigdecimal'
require 'bigdecimal/util'
require 'aequitas/rule'
require 'aequitas/rule/magnitude'

module Aequitas
  class Rule
    class Numericalness < Rule

      equalize_on *superclass.equalizer.keys + [:expected]

      # TODO: move options normalization into the validator macros?
      def self.rules_for(attribute_name, options)
        int = options.values_at(:only_integer, :integer_only).compact.first

        rules = []
        rules << Integer.new(attribute_name, options)    if int
        rules << NonInteger.new(attribute_name, options) if !int
        rules.concat(Magnitude.rules_for(attribute_name, options))
        rules
      end

      attr_reader :expected

      def valid?(resource)
        # TODO: is it even possible for expected to be nil?
        #   if so, return a dummy validator when expected is nil
        return true if expected.nil?

        value = attribute_value(resource)

        skip?(value) || valid_numericalness?(value)
      end

      def valid_numericalness?(value)
        # XXX: workaround for jruby. This is needed because the jruby
        # compiler optimizes a bit too far with magic variables like $~.
        # the value.send line sends $~. Inserting this line makes sure the
        # jruby compiler does not optimise here.
        # see http://jira.codehaus.org/browse/JRUBY-3765
        $~ = nil if RUBY_PLATFORM[/java/]

        value_as_string(value) =~ expected
      rescue ArgumentError
        # TODO: figure out better solution for: can't compare String with Integer
        true
      end

      def value_as_string(value)
        case value
        # Avoid Scientific Notation in Float to_s
        when Float      then value.to_d.to_s('F')
        when BigDecimal then value.to_s('F')
        else value.to_s
        end
      end

    end # class Numericalness
  end # class Rule
end # module Aequitas

require 'aequitas/rule/numericalness/integer'
require 'aequitas/rule/numericalness/non_integer'
