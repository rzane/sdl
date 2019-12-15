require "sdl/types"

module SDL
  class Enum
    include Types::Queries

    attr_reader :name
    attr_reader :values
    attr_reader :default
    attr_reader :options

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

    def type
      :enum
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
