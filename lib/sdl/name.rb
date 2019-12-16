require "active_support/inflector"

module SDL
  # An extension of a string that will format a name
  # This is especially useful for code generation
  class Name < String
    # @api private
    def self.inflect(name, transforms)
      define_method(name) do
        transforms.reduce(self) do |acc, arg|
          case arg
          when :upcase
            acc.upcase
          when :lower_camelize
            ActiveSupport::Inflector.camelize(acc, false)
          when :lower_humanize
            ActiveSupport::Inflector.humanize(acc, capitalize: false)
          else
            ActiveSupport::Inflector.send(arg, acc)
          end
        end
      end
    end

    inflect :table, %i[tableize]
    inflect :snake, %i[underscore]
    inflect :snakes, %i[underscore pluralize]
    inflect :scream, %i[underscore upcase]
    inflect :screams, %i[pluralize underscore upcase]
    inflect :camel, %i[lower_camelize]
    inflect :camels, %i[pluralize lower_camelize]
    inflect :param, %i[dasherize]
    inflect :params, %i[pluralize dasherize]
    inflect :entity, %i[camelize]
    inflect :entities, %i[pluralize camelize]
    inflect :title, %i[titleize]
    inflect :titles, %i[pluralize titleize]
    inflect :label, %i[humanize]
    inflect :labels, %i[pluralize humanize]
    inflect :description, %i[lower_humanize]
    inflect :descriptions, %i[pluralize lower_humanize]
  end
end
