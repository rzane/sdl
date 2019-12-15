require "sdl/types"
require "sdl/attribute"
require "sdl/association"
require "sdl/attachment"
require "active_support/core_ext/string/inflections"

module SDL
  class Parser
    # Parses a string into a {Field}, {Enum}, {Association} or {Attachment}.
    #
    # Supported Directives:
    #
    # * +id+
    # * +string+
    # * +string{limit}*
    # * +text+
    # * +text{limit}*
    # * +integer+
    # * +integer{limit}+
    # * +binary+
    # * +binary{limit}+
    #
    # @param value [String]
    # @raise [ParseError] when a directive is not recognized
    # @return [Field,Enum,Association,Attachment]
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

    TYPES = /^(#{Types.scalar.join("|")})$/
    TYPES_WITH_LIMIT = /^(#{Types.scalar_with_limit.join("|")})\{(\d+)\}$/
    TYPES_WITH_PRECISION = /^(#{Types.scalar_with_precision.join("|")})\{(\d+)[,.-](\d+)\}$/

    ATTACHMENT = /^(has_one|has_many)_attached$/
    ASSOCIATION = /^(#{Types.association.join("|")})$/
    ASSOCIATION_WITH_NAME = /^(#{Types.association.join("|")})\{(.*)\}$/

    DEFAULT = /^default\{(.*)\}$/
    MODIFIERS = %w[required unique index foreign_key]

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
      when ASSOCIATION
        opts[:type] = Association.const_get($1.camelize)
      when ASSOCIATION_WITH_NAME
        opts[:type] = Association.const_get($1.camelize)
        opts[:model_name] = $2.to_sym
      when ATTACHMENT
        opts[:type] = Attachment.const_get($1.camelize)
      when DEFAULT
        opts[:default] = $1
      when *MODIFIERS
        opts[arg.to_sym] = true
      else
        raise ParseError, "Unrecognized parameter: #{arg}"
      end
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
