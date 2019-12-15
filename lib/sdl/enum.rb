module SDL
  class Enum
    attr_reader :name
    attr_reader :values
    attr_reader :options

    def initialize(name, values: [], **options, &block)
      @name = name.to_s
      @values = values
      @options = options
      instance_eval(&block) if block_given?
    end

    def value(value)
      @values << value
    end
  end
end
