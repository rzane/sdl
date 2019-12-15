module SDL
  module Types
    def self.scalar
      %i(id string boolean integer float decimal date datetime text binary)
    end

    def self.association
      %i(belongs_to has_one has_many)
    end

    def self.attachment
      %i(has_one_attached has_many_attached)
    end

    def self.all
      scalar + association + attachment
    end

    module Queries
      def type
        raise NotImplementedError, __method__
      end

      Types.all.each do |meth|
        define_method("#{meth}?") do
          type == meth
        end
      end
    end
  end
end
