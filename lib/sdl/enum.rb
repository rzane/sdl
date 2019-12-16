require "sdl/field"
require "sdl/name"

module SDL
  # A field of a {Model} that has a predefined list of possible values
  class Enum < Field
    include Field::ColumnOptions

    # The type of field
    # @return [Symbol]
    def type
      :enum
    end

    # A default value for this field
    # @return [Name]
    def default
      Name.new(options[:default].to_s) if options[:default]
    end

    # The possible values for the enum
    # @return [Array<Name>]
    def values
      options.fetch(:values, []).map { |value| Name.new(value.to_s) }
    end

    # The name of the column
    # @return [Name]
    def column_name
      name
    end
  end
end
