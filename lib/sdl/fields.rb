require "sdl/field"
require "sdl/association"
require "sdl/attachment"

module SDL
  # A collection of fields
  class Fields
    include Enumerable

    def initialize(fields)
      @fields = fields
    end

    def [](index)
      @fields[index]
    end

    def each(&block)
      @fields.each(&block)
    end

    def attributes
      grep Field
    end

    def associations
      grep Association
    end

    def attachments
      grep Attachment
    end

    def belongs_to
      grep Association::BelongsTo
    end

    def has_one
      grep Association::HasOne
    end

    def has_many
      grep Association::HasMany
    end

    def has_one_attached
      grep Attachment::HasOne
    end

    def has_many_attached
      grep Attachment::HasMany
    end

    Field::TYPES.each do |meth|
      define_method(meth) do
        select { |field| field.type == meth }
      end
    end
  end
end
