require "sdl/types"

module SDL
  class Attachment
    include Types::Queries

    attr_reader :name
    attr_reader :options

    def initialize(name, **options)
      @name = name.to_s
      @options = options
    end
  end

  class Attachment::HasOne < Attachment
    def type
      :has_one_attached
    end
  end

  class Attachment::HasMany < Attachment
    def type
      :has_many_attached
    end
  end
end
