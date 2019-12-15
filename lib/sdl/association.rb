require "active_support/core_ext/string/inflections"

module SDL
  class Association
    attr_reader :name
    attr_reader :model_name
    attr_reader :options

    def initialize(name, model_name: name, **options)
      @name = name
      @model_name = model_name
      @options = options
    end
  end

  class Association::HasOne < Association
  end

  class Association::HasMany < Association
    def initialize(name, model_name: name.to_s.singularize.to_sym, **options)
      super(name, model_name: model_name, **options)
    end
  end

  class Association::BelongsTo < Association
    def initialize(name, required: false, unique: false, **options)
      super(name, options)
      @required = required
      @unique = unique
    end

    def required?
      @required
    end

    def unique?
      @unique
    end
  end
end
