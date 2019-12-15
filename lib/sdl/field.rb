require "sdl/types"

module SDL
  class Field
    include Types::Queries

    attr_reader :name
    attr_reader :type
    attr_reader :default
    attr_reader :limit
    attr_reader :precision
    attr_reader :scale
    attr_reader :options

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

    def required?
      @required
    end

    def unique?
      @unique
    end

    def index?
      @index
    end
  end
end
