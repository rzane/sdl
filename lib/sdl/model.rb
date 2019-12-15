require "sdl/fields"
require "sdl/field"
require "sdl/enum"
require "sdl/association"
require "sdl/attachment"

module SDL
  class Model
    attr_reader :name
    attr_reader :options

    def initialize(name, fields: [], **options, &block)
      @name = name.to_s
      @fields = fields
      @options = options
      instance_eval(&block) if block_given?
    end

    def fields
      Fields.new(@fields)
    end

    def field(*args)
      @fields << Field.new(*args)
    end

    def enum(*args)
      @fields << Enum.new(*args)
    end

    def belongs_to(*args)
      @fields << Association::BelongsTo.new(*args)
    end

    def has_one(*args)
      @fields << Association::HasOne.new(*args)
    end

    def has_many(*args)
      @fields << Association::HasMany.new(*args)
    end

    def has_one_attached(*args)
      @fields << Attachment::HasOne.new(*args)
    end

    def has_many_attached(*args)
      @fields << Attachment::HasMany.new(*args)
    end

    def timestamps
      field :created_at, :datetime, required: true
      field :updated_at, :datetime, required: true
    end
  end
end
