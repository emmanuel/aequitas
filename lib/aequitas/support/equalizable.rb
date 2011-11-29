# -*- encoding: utf-8 -*-

module Aequitas
  # TODO: rename ValueObject (?)
  module Equalizable

    # An Equalizer module which defines #inspect, #eql?, #== and #hash
    # for instances of this class
    attr_reader :equalizer

    # Define and include a module that provides Value Object semantics for
    #   this class. Included module will have #inspect, #eql?, #== and #hash
    #   methods whose definition is based on the _keys_ argument
    #
    # @param [Array(Symbol)] keys
    #   List of keys that will be used to define #inspect, #eql?, #==, and #hash
    #
    # @return [self]
    #
    # @api public
    def equalize_on(keys)
      @equalizer = Equalizer.new(keys)
      @equalizer.compile
      include @equalizer

      self
    end

    class Equalizer < Module
      # List of methods that will be used to compile #inspect,
      #   #eql?, #== and #hash methods
      # 
      # @return [Array(Symbol)]
      attr_reader :keys

      def initialize(keys)
        @keys = keys
      end

      # Compile the equalizer methods based on #keys
      # 
      # @return [self]
      def compile
        define_inspect_method
        define_eql_method
        define_equivalent_method
        define_hash_method

        self
      end

    private

      # Define an inspect method that reports the values of
      #   the instance's methods identified by #keys
      # 
      # @return [self]
      def define_inspect_method
        module_eval <<-RUBY, __FILE__, __LINE__ + 1
          def inspect
            "#<\#{self.class.inspect} #{keys.map { |k| "#{k}=\#{#{k}.inspect}" }.join(' ')}>"
          end
        RUBY
      end

      # Define an #eql? method based on the instance's values identified by #keys
      # 
      # @return [self]
      def define_eql_method
        module_eval <<-RUBY, __FILE__, __LINE__ + 1
          def eql?(other)
            return true if equal?(other)
            instance_of?(other.class) &&
            #{keys.map { |key| "#{key}.eql?(other.#{key})" }.join(' && ')}
          end
        RUBY
      end

      # Define an #== method based on the instance's values identified by #keys
      # 
      # @return [self]
      def define_equivalent_method
        respond_to = []
        equivalent = []

        keys.each do |key|
          respond_to << "other.respond_to?(#{key.inspect})"
          equivalent << "#{key} == other.#{key}"
        end

        module_eval <<-RUBY, __FILE__, __LINE__ + 1
          def ==(other)
            return true if equal?(other)
            return false unless kind_of?(other.class) || other.kind_of?(self.class)
            #{respond_to.join(' && ')} &&
            #{equivalent.join(' && ')}
          end
        RUBY
      end

      # Define a #hash method based on the instance's values identified by #keys
      # 
      # @return [self]
      def define_hash_method
        module_eval <<-RUBY, __FILE__, __LINE__ + 1
          def hash
            self.class.hash ^ #{keys.map { |key| "#{key}.hash" }.join(' ^ ')}
          end
        RUBY
      end
    end # class Equalizer
  end # module Equalizable
end # module Aequitas
