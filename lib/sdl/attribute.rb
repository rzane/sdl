require "sdl/field"

module SDL
  # An attribute of a {Model}
  class Attribute < Field
    # The type of field
    # @return [Symbol]
    attr_reader :type

    # @api private
    def initialize(name, type, **options)
      super(name, options)
      @type = type
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

    # Is this field required?
    # @return [Boolean]
    def required?
      options.fetch(:required, false)
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
