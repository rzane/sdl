require "sdl/field"
require "sdl/types"

module SDL
  # An attribute of a {Model}
  class Attribute < Field
    # The name of the field
    # @return [String]
    attr_reader :name

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

    # Any options for the field
    # @return [Hash{Symbol => Object}]
    attr_reader :options

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
      @name = name.to_s
      @type = type
      @required = required
      @unique = unique
      @index = index
      @default = default
      @limit = limit
      @precision = precision
      @scale = scale
      @options = options
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
