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

    # Is this field required?
    # @return [Boolean]
    def required?
      options.fetch(:required, false)
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

    # Is this field required?
    # @return [Boolean]
    def required?
      true
    end
  end

  # Indicates a one-to-one connection with another {Model}
  class Association::BelongsTo < Association
    include Field::ColumnOptions

    # The type of field
    # @return [Symbol]
    def type
      :belongs_to
    end

    # Should this field have a foreign key?
    # @return [Boolean]
    def foreign_key?
      options.fetch(:foreign_key, false)
    end
  end
end
