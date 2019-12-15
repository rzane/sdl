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
end
