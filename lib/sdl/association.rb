require "sdl/field"
require "active_support/inflector"

module SDL
  # Base class for all association types
  # @abstract
  class Association < Field
    # The name of the associated model
    # @return [Name]
    def model_name
      Name.new(options.fetch(:model_name, name).to_s)
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
    # @return [Name]
    def model_name
      model_name = options.fetch(:model_name) do
        ActiveSupport::Inflector.singularize(name.to_s)
      end

      Name.new(model_name.to_s)
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

    # The name of the column
    # @return [Name]
    def column_name
      Name.new("#{name}_id")
    end
  end
end
