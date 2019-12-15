module SDL
  class Enum
    attr_reader :name
    attr_reader :values
    attr_reader :options

    def initialize(name, values: [], **options)
      @name = name.to_s
      @values = values
      @options = options
    end
  end
end
