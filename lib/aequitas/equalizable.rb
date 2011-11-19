# -*- encoding: utf-8 -*-

module Aequitas
  # TODO: rename ValueObject
  module Equalizable
    attr_reader :equalizer

    def equalize_on(keys)
      @equalizer = Equalizer.new(keys)
      @equalizer.compile
      include @equalizer

      self
    end

    class Equalizer < Module
      attr_reader :keys

      def initialize(keys)
        @keys = keys
      end

      def compile
        define_inspect_method
        define_eql_method
        define_equivalent_method
        define_hash_method
      end

    private

      def define_inspect_method
        module_eval <<-RUBY, __FILE__, __LINE__ + 1
          def inspect
            "#<\#{self.class.inspect} #{keys.map { |k| "#{k}=\#{#{k}.inspect}" }.join(' ')}>"
          end
        RUBY
      end

      def define_eql_method
        module_eval <<-RUBY, __FILE__, __LINE__ + 1
          def eql?(other)
            return true if equal?(other)
            instance_of?(other.class) &&
            #{keys.map { |key| "#{key}.eql?(other.#{key})" }.join(' && ')}
          end
        RUBY
      end

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
