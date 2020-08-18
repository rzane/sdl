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
      super(name, **options)
      @type = type
    end

    # The name of the column
    # @return [Name]
    def column_name
      name
    end
  end
end
