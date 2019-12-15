require "sdl/types"

module SDL
  # A field of a {Model} that has a predefined list of possible values
  class Enum < Field
    include Types::Queries

    # The name of the field
    # @return [String]
    attr_reader :name

    # The possible values for the enum
    # @return [Array<String>]
    attr_reader :values

    # A default value for the enum
    # @return [Object]
    attr_reader :default

    # Any additional options
    # @return [Hash{Symbol => Object}]
    attr_reader :options

    # @api private
    def initialize(
      name,
      values: [],
      required: false,
      unique: false,
      index: false,
      default: nil,
      **options
    )
      @name = name.to_s
      @values = values.map(&:to_s)
      @required = required
      @unique = unique
      @index = index
      @default = default
      @options = options
    end

    # The type of field
    # @return [Symbol]
    def type
      :enum
    end

    # Is this a required field?
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
