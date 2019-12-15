require "sdl/schema"

RSpec.describe SDL::Schema do
  subject(:schema) { described_class.new }

  it "has models" do
    expect(schema.models).to eq([])
  end

  it "accepts definition" do
    schema = SDL::Schema.new do
      model :user
    end

    expect(schema.models.length).to eq(1)
  end

  describe "#find_model" do
    it "finds a model by name" do
      schema = SDL::Schema.new
      schema.model :user
      expect(schema.find_model(:user)).to be_a(SDL::Model)
    end
  end

  describe "depsort!" do
    it "sorts dependent models" do
      schema = SDL::Schema.new do
        model :book do
          belongs_to :author
          has_many :chapters
        end

        model :chapter do
          belongs_to :book
        end

        model :author do
          has_many :books
        end
      end

      expect(schema.models.map(&:name)).to eq(["book", "chapter", "author"])
      schema.depsort!
      expect(schema.models.map(&:name)).to eq(["author", "book", "chapter"])
    end

    it "raises a CirclularDepedencyError when resolution is not possible" do
      schema = SDL::Schema.new do
        model :book do
          belongs_to :author
        end

        model :author do
          belongs_to :book
        end
      end

      expect { schema.depsort! }.to raise_error(SDL::CircularDependencyError)
    end
  end
end
