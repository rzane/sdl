require "sdl/field"
require "sdl/types"

module SDL
  # An attribute of a {Model}
  class Attribute < Field
    # The type of field
    # @return [Symbol]
    attr_reader :type

    # A default value for this field
    # @return [Object]
    attr_reader :default

    # A limit for the field
    # @return [Integer]
    attr_reader :limit

    # A precision for the field
    # @return [Integer]
    attr_reader :precision

    # A scale for the field
    # @return [Integer]
    attr_reader :scale

    # @api private
    def initialize(
      name,
      type,
      required: false,
      unique: false,
      index: false,
      default: nil,
      limit: nil,
      precision: nil,
      scale: nil,
      **options
    )
      super(name, options)
      @type = type
      @required = required
      @unique = unique
      @index = index
      @default = default
      @limit = limit
      @precision = precision
      @scale = scale
    end

    # Is this field required?
    # @return [Boolean]
    def required?
      @required
    end

    # Is this field unique?
    # @return [Boolean]
    def unique?
      @unique
    end

    # Should this field have an index?
    # @return [Boolean]
    def index?
      @index
    end
  end
end
