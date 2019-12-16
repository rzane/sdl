require "sdl/field"
require "active_support/core_ext/string/inflections"

module SDL
  # Base class for all association types
  # @abstract
  class Association < Field
    # The name of the associated model
    # @return [String]
    def model_name
      options.fetch(:model_name, name).to_s
    end
  end

  # Indicates a one-to-one connection with another {Model}
  class Association::HasOne < Association
    # The type of field
    # @return [Symbol]
    def type
      :has_one
    end
  end

  # Indicates a one-to-many connection with another {Model}
  class Association::HasMany < Association
    # The type of field
    # @return [Symbol]
    def type
      :has_many
    end

    # The name of the associated model
    # @return [String]
    def model_name
      options.fetch(:model_name) { name.singularize }.to_s
    end
  end

  # Indicates a one-to-one connection with another {Model}
  class Association::BelongsTo < Association
    # The type of field
    # @return [Symbol]
    def type
      :belongs_to
    end

    # Is this field required?
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

    # Should this field have a foreign key?
    # @return [Boolean]
    def foreign_key?
      options.fetch(:foreign_key, false)
    end
  end
end
