require "sdl/field"

module SDL
  # Base class for all attachment types
  # @abstract
  class Attachment < Field
  end

  # A file that is attached to a {Model}
  class Attachment::HasOne < Attachment
    # The type of field
    # @return [Symbol]
    def type
      :has_one_attached
    end

    # Is this field required?
    # @return [Boolean]
    def required?
      options.fetch(:required, false)
    end
  end

  # A list of files that are attached to a {Model}
  class Attachment::HasMany < Attachment
    # The type of field
    # @return [Symbol]
    def type
      :has_many_attached
    end

    # Is this field required?
    # @return [Boolean]
    def required?
      true
    end
  end
end
