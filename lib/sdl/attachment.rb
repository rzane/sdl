module SDL
  class Attachment
    attr_reader :name
    attr_reader :options

    def initialize(name, **options)
      @name = name.to_s
      @options = options
    end
  end

  class Attachment::HasOne < Attachment
  end

  class Attachment::HasMany < Attachment
  end
end
