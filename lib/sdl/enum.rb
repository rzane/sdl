require "sdl/field"

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
    # @return [Object]
    def default
      options[:default]&.to_s
    end

    # The possible values for the enum
    # @return [Array<String>]
    def values
      options.fetch(:values, []).map(&:to_s)
    end
  end
end
