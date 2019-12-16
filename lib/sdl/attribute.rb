require "sdl/field"

module SDL
  # An attribute of a {Model}
  class Attribute < Field
    include Field::ColumnOptions

    # The type of field
    # @return [Symbol]
    attr_reader :type

    # @api private
    def initialize(name, type, **options)
      super(name, options)
      @type = type
    end
  end
end
