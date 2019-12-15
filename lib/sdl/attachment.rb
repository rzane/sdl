require "sdl/field"
require "sdl/types"

module SDL
  # Base class for all attachment types
  # @abstract
  class Attachment < Field
    include Types::Queries

    # The name of the field
    # @return [String]
    attr_reader :name

    # Any additional options
    # @return [Hash{Symbol => Object}]
    attr_reader :options

    # @api private
    def initialize(name, **options)
      @name = name.to_s
      @options = options
    end
  end

  # A file that is attached to a {Model}
  class Attachment::HasOne < Attachment
    # The type of field
    # @return [Symbol]
    def type
      :has_one_attached
    end
  end

  # A list of files that are attached to a {Model}
  class Attachment::HasMany < Attachment
    # The type of field
    # @return [Symbol]
    def type
      :has_many_attached
    end
  end
end
