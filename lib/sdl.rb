require "sdl/version"
require "sdl/parser"
require "sdl/schema"

module SDL
  class Error < StandardError
  end

  class ParseError < Error
  end

  class CircularDependencyError < Error
  end

  def self.define(&block)
    Schema.new(&block)
  end

  def self.load_file(file)
    schema = Schema.new
    schema.instance_eval(File.read(file), file)
    schema
  end

  def self.parse(name, fields)
    parser = Parser.new
    fields = fields.map { |field| parser.parse(field) }
    Model.new(name, fields: fields)
  end
end
