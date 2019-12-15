require "sdl/version"
require "sdl/parser"
require "sdl/schema"

module SDL
  # A base class for all errors
  class Error < StandardError
  end

  # Raised when the parser encounters an unrecognized directive
  class ParseError < Error
  end

  # Raised when models can't be sorted by their dependencies
  class CircularDependencyError < Error
  end

  # Defines a new schema. The block will be evaluated in the
  # context of a {Schema}
  #
  # @example
  #   SDL.define do
  #     model :user do
  #       field :name, :string
  #     end
  #   end
  def self.define(&block)
    Schema.new(&block)
  end

  # Loads a schema from a file. The contents of the file
  # will be evaluated in the context of a {Schema}
  #
  # @example
  #   SDL.load_file("schema.rb")
  def self.load_file(file)
    schema = Schema.new
    schema.instance_eval(File.read(file), file)
    schema
  end

  # Constructs a model from command-line arguments
  # @raise [ParseError]
  # @see Parser
  #
  # @example
  #   SDL.parse("user", ["name", "email:required:unique"])
  def self.parse(name, fields)
    parser = Parser.new
    fields = fields.map { |field| parser.parse(field) }
    Model.new(name, fields: fields)
  end
end
