require "sdl/types"
require "sdl/field"
require "sdl/attribute"
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
    # @return [Field,nil]
    def [](index)
      @fields[index]
    end

    # Iterate over all fields
    # @yieldparam [Field]
    def each(&block)
      @fields.each(&block)
    end

    # Get all instances of {Attribute}
    # @return [Array<Attribute>]
    def attributes
      grep Attribute
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
    #   Get all instances of {Attribute} whose type is +:id+
    #   @return [Array<Attribute>]
    # @!method string
    #   Get all instances of {Attribute} whose type is +:string+
    #   @return [Array<Attribute>]
    # @!method boolean
    #   Get all instances of {Attribute} whose type is +:boolean+
    #   @return [Array<Attribute>]
    # @!method integer
    #   Get all instances of {Attribute} whose type is +:integer+
    #   @return [Array<Attribute>]
    # @!method float
    #   Get all instances of {Attribute} whose type is +:float+
    #   @return [Array<Attribute>]
    # @!method decimal
    #   Get all instances of {Attribute} whose type is +:decimal+
    #   @return [Array<Attribute>]
    # @!method date
    #   Get all instances of {Attribute} whose type is +:date+
    #   @return [Array<Attribute>]
    # @!method datetime
    #   Get all instances of {Attribute} whose type is +:datetime+
    #   @return [Array<Attribute>]
    # @!method text
    #   Get all instances of {Attribute} whose type is +:text+
    #   @return [Array<Attribute>]
    # @!method binary
    #   Get all instances of {Attribute} whose type is +:binary+
    #   @return [Array<Attribute>]
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
    SDL::TYPES.each do |meth|
      define_method meth do
        select { |field| field.type == meth }
      end
    end
  end
end
