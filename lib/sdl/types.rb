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
      scalar + association + attachment
    end

    module Queries
      Types.all.each do |meth|
        define_method("#{meth}?") do
          type == meth
        end
      end
    end
  end
end
