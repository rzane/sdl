require "sdl/types"

module SDL
  # A base class for all fields of a model
  # @abstract
  class Field
    # The name of the field
    # @return [String]
    attr_reader :name

    # All options that were passed to the field
    # @return [Hash]
    attr_reader :options

    # @api private
    def initialize(name, **options)
      @name = name.to_s
      @options = options
    end

    # Indicates that this is an {Attribute}
    # @return [Boolean]
    def attribute?
      !enum? && !association? && !attachment?
    end

    # Indicates that this is an {Attachment}
    # @return [Boolean]
    def attachment?
      has_one_attached? || has_many_attached?
    end

    # Indicates that this is an {Association}
    # @return [Boolean]
    def association?
      has_one? || has_many? || belongs_to?
    end

    # @!method id?
    #   Indicates that this is an {Attribute} whose type is `:id`
    #   @return [Boolean]
    # @!method string?
    #   Indicates that this is an {Attribute} whose type is `:string`
    #   @return [Boolean]
    # @!method boolean?
    #   Indicates that this is an {Attribute} whose type is `:boolean`
    #   @return [Boolean]
    # @!method integer?
    #   Indicates that this is an {Attribute} whose type is `:integer`
    #   @return [Boolean]
    # @!method float?
    #   Indicates that this is an {Attribute} whose type is `:float`
    #   @return [Boolean]
    # @!method decimal?
    #   Indicates that this is an {Attribute} whose type is `:decimal`
    #   @return [Boolean]
    # @!method date?
    #   Indicates that this is an {Attribute} whose type is `:date`
    #   @return [Boolean]
    # @!method datetime?
    #   Indicates that this is an {Attribute} whose type is `:datetime`
    #   @return [Boolean]
    # @!method text?
    #   Indicates that this is an {Attribute} whose type is `:text`
    #   @return [Boolean]
    # @!method binary?
    #   Indicates that this is an {Attribute} whose type is `:binary`
    #   @return [Boolean]
    # @!method enum?
    #   Indicates that this is an {Enum}
    #   @return [Boolean]
    # @!method belongs_to?
    #   Indicates that this is an {Association::BelongsTo}
    #   @return [Boolean]
    # @!method has_one?
    #   Indicates that this is an {Association::HasOne}
    #   @return [Boolean]
    # @!method has_many?
    #   Indicates that this is an {Association::HasMany}
    #   @return [Boolean]
    # @!method has_one_attached?
    #   Indicates that this is an {Attachment::HasOne}
    #   @return [Boolean]
    # @!method has_many_attached?
    #   Indicates that this is an {Attachment::HasMany}
    #   @return [Boolean]
    TYPES.each do |meth|
      define_method "#{meth}?" do
        type == meth
      end
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
