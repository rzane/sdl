require "sdl/types"
require "sdl/field"
require "sdl/enum"
require "sdl/attribute"
require "sdl/association"
require "sdl/attachment"
require "active_support/inflector"

module SDL
  # The parser takes a string and converts it to a {Field}.
  # A field is described using a series of directives separated
  # by a colon.
  #
  # Examples:
  #
  # * `title:string{120}:required`
  # * `body:text`
  # * `status:enum{draft,published}`
  # * `user:belongs_to:foreign_key`
  # * `image:has_one_attached`
  #
  # Available directives:
  #
  # * `id`
  # * `string`
  # * `string{limit}`
  # * `boolean`
  # * `integer`
  # * `integer{limit}`
  # * `float`
  # * `decimal`
  # * `decimal{precision,scale}`
  # * `date`
  # * `datetime`
  # * `text`
  # * `text{limit}`
  # * `binary`
  # * `binary{limit}`
  # * `enum{value,...}`
  # * `belongs_to`
  # * `belongs_to{model}`
  # * `has_one`
  # * `has_one{model}`
  # * `has_many`
  # * `has_many{model}`
  # * `has_one_attached`
  # * `has_many_attached`
  # * `unique`
  # * `nullable`
  # * `index`
  # * `foreign_key`
  # * `default{value}`
  class Parser
    # Parses a string into a {Field}
    # @param value [String]
    # @raise [ParseError] when a directive is not recognized
    # @return [Field]
    def parse(value)
      name, *args = value.split(":")
      name = name.to_sym

      opts = {type: :string}
      args.each { |arg| parse!(arg, opts) }
      type = opts.delete(:type)

      # Attempt to coerce the default
      opts[:default] = coerce(opts[:default], type) if opts[:default]

      if type.is_a?(Symbol)
        Attribute.new(name, type, opts)
      else
        type.new(name, opts)
      end
    end

    private

    SEPARATOR = /[,.-]/
    TYPES = /^(#{SCALAR_TYPES.join("|")})$/
    TYPES_WITH_LIMIT = /^(string|text|binary|integer)\{(\d+)\}$/
    TYPES_WITH_PRECISION = /^(decimal)\{(\d+)#{SEPARATOR}(\d+)\}$/

    ENUM = /^enum\{(.*)\}$/
    ATTACHMENT = /^(has_one|has_many)_attached$/
    ASSOCIATION = /^(belongs_to|has_one|has_many)$/
    ASSOCIATION_WITH_NAME = /^(belongs_to|has_one|has_many)\{(.*)\}$/

    DEFAULT = /^default\{(.*)\}$/
    MODIFIERS = %w[nullable unique index foreign_key]

    def parse!(arg, opts)
      case arg
      when TYPES
        opts[:type] = $1.to_sym
      when TYPES_WITH_LIMIT
        opts[:type] = $1.to_sym
        opts[:limit] = $2.to_i
      when TYPES_WITH_PRECISION
        opts[:type] = $1.to_sym
        opts[:precision] = $2.to_i
        opts[:scale] = $3.to_i
      when ENUM
        opts[:type] = Enum
        opts[:values] = $1.split(SEPARATOR)
      when ASSOCIATION
        opts[:type] = Association.const_get(camelize($1))
      when ASSOCIATION_WITH_NAME
        opts[:type] = Association.const_get(camelize($1))
        opts[:model_name] = $2.to_sym
      when ATTACHMENT
        opts[:type] = Attachment.const_get(camelize($1))
      when DEFAULT
        opts[:default] = $1
      when *MODIFIERS
        opts[arg.to_sym] = true
      else
        raise ParseError, "Unrecognized parameter: #{arg}"
      end
    end

    def camelize(value)
      ActiveSupport::Inflector.camelize(value)
    end

    def coerce(value, type)
      case type
      when :integer then value.to_i
      when :float then value.to_f
      when :boolean then value.match?(/^true$/)
      else
        value
      end
    end
  end
end
