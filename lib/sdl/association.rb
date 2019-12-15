require "active_support/core_ext/string/inflections"

module SDL
  class Association
    attr_reader :name
    attr_reader :model_name
    attr_reader :options

    def initialize(name, model_name: name, **options)
      @name = name.to_s
      @model_name = model_name.to_s
      @options = options
    end
  end

  class Association::HasOne < Association
    def type
      :has_one
    end
  end

  class Association::HasMany < Association
    def initialize(name, model_name: name.to_s.singularize, **options)
      super(name, model_name: model_name, **options)
    end

    def type
      :has_many
    end
  end

  class Association::BelongsTo < Association
    def initialize(
      name,
      required: false,
      unique: false,
      index: false,
      foreign_key: false,
      **options
    )
      super(name, options)
      @required = required
      @unique = unique
      @index = index
      @foreign_key = foreign_key
    end

    def type
      :belongs_to
    end

    def required?
      @required
    end

    def unique?
      @unique
    end

    def index?
      @index
    end

    def foreign_key?
      @foreign_key
    end
  end
end
