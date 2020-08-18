require "sdl/association"
require "sdl/attachment"
require "sdl/attribute"
require "sdl/enum"
require "sdl/name"

module SDL
  class Model
    # Name of the model
    # @return [Name]
    attr_reader :name

    # Any additional options
    # @return [Hash]
    attr_reader :options

    # @api private
    def initialize(name, fields: [], **options, &block)
      @name = Name.new(name.to_s)
      @fields = fields
      @options = options
      instance_eval(&block) if block_given?
    end

    # Get or filter fields that have been registered
    # @param types [Array<Symbol>] types to filter
    # @return [Array<Field>]
    def fields(*types)
      return @fields if types.empty?

      types.flat_map { |type|
        case type
        when :attribute
          @fields.grep Attribute
        when :association
          @fields.grep Association
        when :attachment
          @fields.grep Attachment
        else
          @fields.select { |field| field.type == meth }
        end
      }
    end

    # Adds an {Attribute} to the model
    # @param name [Symbol]
    # @param type [Symbol]
    # @option options [Boolean] :nullable
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
    # @option options [Boolean] :nullable
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
    # @option options [Boolean] :nullable
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
    # @option options [Boolean] :nullable
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
    # @option options [Symbol] :nullable
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

    # Get all {Attribute} fields
    # @return [Array<Attribute>]
    def attribute_fields
      fields.grep Attribute
    end

    # Get all {Association} fields
    # @return [Array<Association>]
    def association_fields
      fields.grep Association
    end

    # Get all {Attachment} fields
    # @return [Array<Attachment>]
    def attachment_fields
      fields.grep Attachment
    end

    # @!method id_fields
    #   Get all {Attribute} fields whose type is `:id`
    #   @return [Array<Attribute>]
    # @!method string_fields
    #   Get all {Attribute} fields whose type is `:string`
    #   @return [Array<Attribute>]
    # @!method boolean_fields
    #   Get all {Attribute} fields whose type is `:boolean`
    #   @return [Array<Attribute>]
    # @!method integer_fields
    #   Get all {Attribute} fields whose type is `:integer`
    #   @return [Array<Attribute>]
    # @!method float_fields
    #   Get all {Attribute} fields whose type is `:float`
    #   @return [Array<Attribute>]
    # @!method decimal_fields
    #   Get all {Attribute} fields whose type is `:decimal`
    #   @return [Array<Attribute>]
    # @!method date_fields
    #   Get all {Attribute} fields whose type is `:date`
    #   @return [Array<Attribute>]
    # @!method datetime_fields
    #   Get all {Attribute} fields whose type is `:datetime`
    #   @return [Array<Attribute>]
    # @!method text_fields
    #   Get all {Attribute} fields whose type is `:text`
    #   @return [Array<Attribute>]
    # @!method binary_fields
    #   Get all {Attribute} fields whose type is `:binary`
    #   @return [Array<Attribute>]
    # @!method enum_fields
    #   Get all {Enum} fields
    #   @return [Array<Enum>]
    # @!method belongs_to_fields
    #   Get all {Association::BelongsTo} fields
    #   @return [Array<Association::BelongsTo>]
    # @!method has_one_fields
    #   Get all {Association::HasOne} fields
    #   @return [Array<Assocation::HasOne>]
    # @!method has_many_fields
    #   Get all {Association::HasMany} fields
    #   @return [Array<Association::HasMany>]
    # @!method has_one_attached_fields
    #   Get all {Attachment::HasOne} fields
    #   @return [Array<Attachment::HasOne>]
    # @!method has_many_attached_fields
    #   Get all {Attachment::HasMany} fields
    #   @return [Array<Attachment::HasMany>]
    TYPES.each do |meth|
      define_method "#{meth}_fields" do
        fields.select { |field| field.type == meth }
      end
    end
  end
end
