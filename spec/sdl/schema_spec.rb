require "sdl/schema"

RSpec.describe SDL::Schema do
  subject(:schema) { described_class.new }

  it "has models" do
    expect(schema.models).to eq([])
  end

  it "has enums" do
    expect(schema.enums).to eq([])
  end

  it "accepts definition" do
    schema = SDL::Schema.new do
      enum :status
      model :user
    end

    expect(schema.enums.length).to eq(1)
    expect(schema.models.length).to eq(1)
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
  end
end
