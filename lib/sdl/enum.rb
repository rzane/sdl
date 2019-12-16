require "sdl/field"

module SDL
  # A field of a {Model} that has a predefined list of possible values
  class Enum < Field
    # The type of field
    # @return [Symbol]
    def type
      :enum
    end

    # The possible values for the enum
    # @return [Array<String>]
    def values
      options.fetch(:values, []).map(&:to_s)
    end

    # A default value for the enum
    # @return [Object]
    def default
      options[:default]
    end

    # Is this a required field?
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
