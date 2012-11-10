#encoding: utf-8

module Aequitas
  class Rule
    class Format
      class Proc < Format

        def expected_format?(value)
          format.call(value)
        end

      end # class Proc
    end # class Format
  end # class Rule
end # module Aequitas
