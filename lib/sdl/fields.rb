require "sdl/types"
require "sdl/field"
require "sdl/enum"
require "sdl/association"
require "sdl/attachment"

module SDL
  # All fields of a {Model}
  class Fields
    include Enumerable

    # @api private
    def initialize(fields)
      @fields = fields
    end

    # Get a field by index
    # @param index [Integer]
    # @return [Field,Enum,Association,Attachment,nil]
    def [](index)
      @fields[index]
    end

    # Iterate over all fields
    # @yieldparam [Field,Enum,Association,Attachment]
    def each(&block)
      @fields.each(&block)
    end

    # Get all instances of {Field}
    # @return [Array<Field>]
    def attributes
      grep Field
    end

    # Get all instances of {Association}
    # @return [Array<Association>]
    def associations
      grep Association
    end

    # Get all instances of {Attachment}
    # @return [Array<Attachment>]
    def attachments
      grep Attachment
    end

    # @!method id
    #   Get all instances of {Field} whose type is +:id+
    #   @return [Array<Field>]
    # @!method string
    #   Get all instances of {Field} whose type is +:string+
    #   @return [Array<Field>]
    # @!method boolean
    #   Get all instances of {Field} whose type is +:boolean+
    #   @return [Array<Field>]
    # @!method integer
    #   Get all instances of {Field} whose type is +:integer+
    #   @return [Array<Field>]
    # @!method float
    #   Get all instances of {Field} whose type is +:float+
    #   @return [Array<Field>]
    # @!method decimal
    #   Get all instances of {Field} whose type is +:decimal+
    #   @return [Array<Field>]
    # @!method date
    #   Get all instances of {Field} whose type is +:date+
    #   @return [Array<Field>]
    # @!method datetime
    #   Get all instances of {Field} whose type is +:datetime+
    #   @return [Array<Field>]
    # @!method text
    #   Get all instances of {Field} whose type is +:text+
    #   @return [Array<Field>]
    # @!method binary
    #   Get all instances of {Field} whose type is +:binary+
    #   @return [Array<Field>]
    # @!method enum
    #   Get all instances of {Enum}
    #   @return [Array<Enum>]
    # @!method belongs_to
    #   Get all instances of {Association::BelongsTo}
    #   @return [Array<Association::BelongsTo>]
    # @!method has_one
    #   Get all instances of {Association::HasOne}
    #   @return [Array<Assocation::HasOne>]
    # @!method has_many
    #   Get all instances of {Association::HasMany}
    #   @return [Array<Association::HasMany>]
    # @!method has_one_attached
    #   Indicates that this is an {Attachment::HasOne}
    #   @return [Array<Attachment::HasOne>]
    # @!method has_many_attached
    #   Indicates that this is an {Attachment::HasMany}
    #   @return [Array<Attachment::HasMany>]
    Types.all.each do |meth|
      define_method(meth) do
        select { |field| field.type == meth }
      end
    end
  end
end
