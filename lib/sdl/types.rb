module SDL
  module Types
    def self.scalar
      %i[id string boolean integer float decimal date datetime text binary]
    end

    def self.scalar_with_limit
      %i[string text binary integer]
    end

    def self.scalar_with_precision
      %i[decimal]
    end

    def self.association
      %i[belongs_to has_one has_many]
    end

    def self.attachment
      %i[has_one_attached has_many_attached]
    end

    def self.all
      scalar + association + attachment + %i[enum]
    end

    module Queries
      # @!method id?
      #   Indicates that this is an {Attribute} whose type is +:id+
      #   @return [Boolean]
      # @!method string?
      #   Indicates that this is an {Attribute} whose type is +:string+
      #   @return [Boolean]
      # @!method boolean?
      #   Indicates that this is an {Attribute} whose type is +:boolean+
      #   @return [Boolean]
      # @!method integer?
      #   Indicates that this is an {Attribute} whose type is +:integer+
      #   @return [Boolean]
      # @!method float?
      #   Indicates that this is an {Attribute} whose type is +:float+
      #   @return [Boolean]
      # @!method decimal?
      #   Indicates that this is an {Attribute} whose type is +:decimal+
      #   @return [Boolean]
      # @!method date?
      #   Indicates that this is an {Attribute} whose type is +:date+
      #   @return [Boolean]
      # @!method datetime?
      #   Indicates that this is an {Attribute} whose type is +:datetime+
      #   @return [Boolean]
      # @!method text?
      #   Indicates that this is an {Attribute} whose type is +:text+
      #   @return [Boolean]
      # @!method binary?
      #   Indicates that this is an {Attribute} whose type is +:binary+
      #   @return [Boolean]
      # @!method enum?
      #   Indicates that this is an {Enum}
      #   @return [Boolean]
      # @!method belongs_to?
      #   Indicates that this is an {Association::BelongsTo}
      #   @return [Boolean]
      # @!method has_one?
      #   Indicates that this is an {Association::HasOne}
      #   @return [Boolean]
      # @!method has_many?
      #   Indicates that this is an {Association::HasMany}
      #   @return [Boolean]
      # @!method has_one_attached?
      #   Indicates that this is an {Attachment::HasOne}
      #   @return [Boolean]
      # @!method has_many_attached?
      #   Indicates that this is an {Attachment::HasMany}
      #   @return [Boolean]

      Types.all.each do |meth|
        define_method("#{meth}?") do
          type == meth
        end
      end
    end
  end
end
