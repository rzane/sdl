require "tsort"
require "sdl/model"

module SDL
  class Schema
    # All models that have been defined
    # @return [Array<Model>]
    attr_reader :models

    # @api private
    def initialize(&block)
      @models = []
      instance_eval(&block) if block_given?
    end

    # Find a model by name
    # @param name [Symbol,String] name of the model to find
    # @return [Model,nil]
    def find_model(name)
      models.find { |m| m.name == name.to_s }
    end

    # Adds a new {Model} to the schema
    # @param name [Symbol]
    # @param options [Hash]
    #
    # @example
    #   model :user do
    #     field :name, :string
    #   end
    def model(name, **options, &block)
      @models << Model.new(name, **options, &block)
    end

    # Sort all {Model} instances in order of dependency
    # @raise [CircularDependencyError]
    def depsort!
      each_node = models.method(:each)
      each_child = lambda do |model, &block|
        belongs_to = model.fields.belongs_to.map(&:model_name)
        children = models.select { |m| belongs_to.include?(m.name) }
        children.each(&block)
      end

      @models = TSort.tsort(each_node, each_child)
      @models
    rescue TSort::Cyclic
      raise CircularDependencyError, "The schema contains a circular dependency."
    end
  end
end
