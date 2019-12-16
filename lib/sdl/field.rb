module SDL
  # A base class for all fields of a model
  class Field
    include Types::Queries

    # The name of the field
    # @return [String]
    attr_reader :name

    # Any additional options
    # @return [Hash]
    attr_reader :options

    def initialize(name, **options)
      @name = name.to_s
      @options = options
    end

    module ColumnOptions
      # Is this field required?
      # @return [Boolean]
      def required?
        options.fetch(:required, false)
      end

      # A default value for this field
      # @return [Object]
      def default
        options[:default]
      end

      # A limit for the field
      # @return [Integer]
      def limit
        options[:limit]
      end

      # A precision for the field
      # @return [Integer]
      def precision
        options[:precision]
      end

      # A scale for the field
      # @return [Integer]
      def scale
        options[:scale]
      end

      # Is this field unique?
      # @return [Boolean]
      def unique?
        options.fetch(:unique, false)
      end

      # Should this field have an index?
      # @return [Boolean]
      def index?
        options.fetch(:index, false)
      end
    end
  end
end
