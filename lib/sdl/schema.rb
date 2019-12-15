require "tsort"
require "sdl/model"

module SDL
  class Error < StandardError
  end

  class Schema
    attr_reader :models

    def initialize(&block)
      @models = []
      instance_eval(&block) if block_given?
    end

    def find_model(name)
      models.find { |m| m.name == name.to_s }
    end

    def model(*args, &block)
      @models << Model.new(*args, &block)
    end

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
