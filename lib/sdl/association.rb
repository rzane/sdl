require "sdl/field"
require "sdl/types"
require "active_support/core_ext/string/inflections"

module SDL
  # Base class for all association types
  # @abstract
  class Association < Field
    # The name of the field
    # @return [String]
    attr_reader :name

    # The name of the associated model
    # @return [String]
    attr_reader :model_name

    # Any additional options
    # @return [Hash{Symbol => Object}]
    attr_reader :options

    # @api private
    def initialize(name, model_name: name, **options)
      @name = name.to_s
      @model_name = model_name.to_s
      @options = options
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
    # @api private
    def initialize(name, model_name: name.to_s.singularize, **options)
      super(name, model_name: model_name, **options)
    end

    # The type of field
    # @return [Symbol]
    def type
      :has_many
    end
  end

  # Indicates a one-to-one connection with another {Model}
  class Association::BelongsTo < Association
    # @api private
    def initialize(
      name,
      required: false,
      unique: false,
      index: false,
      foreign_key: false,
      **options
    )
      super(name, **options)
      @required = required
      @unique = unique
      @index = index
      @foreign_key = foreign_key
    end

    # The type of field
    # @return [Symbol]
    def type
      :belongs_to
    end

    # Is this field required?
    # @return [Boolean]
    def required?
      @required
    end

    # Is this field unique?
    # @return [Boolean]
    def unique?
      @unique
    end

    # Should this field have an index?
    # @return [Boolean]
    def index?
      @index
    end

    # Should this field have a foreign key?
    # @return [Boolean]
    def foreign_key?
      @foreign_key
    end
  end
end
