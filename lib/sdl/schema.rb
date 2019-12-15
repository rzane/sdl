require "tsort"
require "sdl/enum"
require "sdl/model"

module SDL
  class Error < StandardError
  end

  class Schema
    attr_reader :models
    attr_reader :enums

    def initialize(&block)
      @models = []
      @enums = []
      instance_eval(&block) if block_given?
    end

    def model(*args, &block)
      @models << Model.new(*args, &block)
    end

    def enum(*args)
      @enums << Enum.new(*args)
    end

    def find_model(name)
      models.find { |m| m.name == name.to_s }
    end

    def find_enum(name)
      enums.find { |e| e.name == name.to_s }
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
      raise Error, "The schema contains a circular dependency."
    end
  end
end
