# encoding: utf-8

require 'aequitas/rule/format'

module Aequitas
  class Rule
    class Format

      # Regex from http://www.igvita.com/2006/09/07/validating-url-in-ruby-on-rails/
      URL = begin
        /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}((\:[0-9]{1,5})?\/?.*)?$)/ix
      end

      Format::FORMATS[:url] = URL

    end # class Format
  end # class Rule
end # module Aequitas
