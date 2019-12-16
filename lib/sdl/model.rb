require "sdl/fields"
require "sdl/attribute"
require "sdl/enum"
require "sdl/association"
require "sdl/attachment"

module SDL
  class Model
    # Name of the model
    # @return [String]
    attr_reader :name

    # Any additional options
    # @return [Hash]
    attr_reader :options

    # @api private
    def initialize(name, fields: [], **options, &block)
      @name = name.to_s
      @fields = fields
      @options = options
      instance_eval(&block) if block_given?
    end

    # All of the fields that have been registered
    # @return [Fields]
    def fields
      Fields.new(@fields)
    end

    # Adds an {Attribute} to the model
    # @param name [Symbol]
    # @param type [Symbol]
    # @option options [Boolean] :required
    # @option options [Boolean] :unique
    # @option options [Object] :default
    # @option options [Integer] :limit
    # @option options [Integer] :precision
    # @option options [Integer] :scale
    #
    # @example
    #   model :user do
    #     attribute :name, :string, required: true
    #   end
    def attribute(name, type, **options)
      @fields << Attribute.new(*name, type, **options)
    end

    # Adds an {Enum} to the model
    # @param name [Symbol]
    # @option options [Array<Symbol>] :values
    # @option options [Boolean] :required
    # @option options [Boolean] :unique
    # @option options [Object] :default
    #
    # @example
    #   model :user do
    #     enum :status, values: [:accepted, :rejected], required: true
    #   end
    def enum(name, **options)
      @fields << Enum.new(name, **options)
    end

    # Adds an {Association::BelongsTo} to the model
    # @param name [Symbol]
    # @option options [Symbol] :model_name
    # @option options [Boolean] :required
    # @option options [Boolean] :unique
    # @option options [Boolean] :foreign_key
    #
    # @example
    #   model :user do
    #     belongs_to :organization, required: true
    #   end
    def belongs_to(name, **options)
      @fields << Association::BelongsTo.new(name, **options)
    end

    # Adds an {Association::HasOne} to the model
    # @param name [Symbol]
    # @option options [Symbol] :model_name
    #
    # @example
    #   model :user do
    #     has_one :profile
    #   end
    def has_one(name, **options)
      @fields << Association::HasOne.new(name, **options)
    end

    # Adds an {Association::HasMany} to the model
    # @param name [Symbol]
    # @option options [Symbol] :model_name
    #
    # @example
    #   model :user do
    #     has_many :devices
    #   end
    def has_many(name, **options)
      @fields << Association::HasMany.new(name, **options)
    end

    # Adds an {Attachment::HasOne} to the model
    # @param name [Symbol]
    # @option options [Hash]
    #
    # @example
    #   model :user do
    #     has_one_attached :avatar
    #   end
    def has_one_attached(name, **options)
      @fields << Attachment::HasOne.new(name, **options)
    end

    # Adds an {Attachment::HasMany} to the model
    # @param name [Symbol]
    # @param options [Hash]
    #
    # @example
    #   model :product do
    #     has_many_attached :images
    #   end
    def has_many_attached(name, **options)
      @fields << Attachment::HasMany.new(name, **options)
    end

    # Adds attributes for +:created_at+ and +:updated_at+ to the model
    #
    # @example
    #   model :user do
    #     timestamps
    #   end
    def timestamps
      attribute :created_at, :datetime, required: true
      attribute :updated_at, :datetime, required: true
    end
  end
end
