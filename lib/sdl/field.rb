module SDL
  # A base class for all fields of a model
  class Field
    include Types::Queries

    # The name of the field
    # @return [String]
    attr_reader :name

    # Any additional options
    # @return [Hash]
    attr_reader :options

    def initialize(name, **options)
      @name = name.to_s
      @options = options
    end
  end
end
