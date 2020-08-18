RSpec.describe SDL::Model do
  subject(:model) {
    SDL::Model.new(:user, foo: :bar)
  }

  it "has a name" do
    expect(model.name).to eq("user")
  end

  it "has options" do
    expect(model.options).to eq(foo: :bar)
  end

  it "has fields" do
    expect(model.fields).to eq([])
  end

  it "accepts an attribute" do
    model.attribute :name, :string
    expect(model.fields.first).to be_an(SDL::Attribute)
  end

  it "accepts an enum" do
    model.enum :status
    expect(model.fields.first).to be_an(SDL::Enum)
  end

  it "accepts a belongs_to association" do
    model.belongs_to :user
    expect(model.fields.first).to be_an(SDL::Association::BelongsTo)
  end

  it "accepts a has_one association" do
    model.has_one :user
    expect(model.fields.first).to be_an(SDL::Association::HasOne)
  end

  it "accepts a has_many association" do
    model.has_many :users
    expect(model.fields.first).to be_an(SDL::Association::HasMany)
  end

  it "accepts a has_one attachment" do
    model.has_one_attached :avatar
    expect(model.fields.first).to be_an(SDL::Attachment::HasOne)
  end

  it "accepts a has_many attachment" do
    model.has_many_attached :avatars
    expect(model.fields.first).to be_an(SDL::Attachment::HasMany)
  end

  it "accepts timestamps" do
    model.timestamps
    expect(model.fields[0].name).to eq("created_at")
    expect(model.fields[1].name).to eq("updated_at")
  end

  describe "field collections" do
    before do
      model.attribute :string, :string
      model.attribute :integer, :integer
      model.enum :enum
      model.belongs_to :belongs_to
      model.has_one :has_one
      model.has_many :has_many
      model.has_one_attached :has_one_attached
      model.has_many_attached :has_many_attached
    end

    it "selects attributes" do
      expect(model.fields(:attribute).map(&:name)).to eq(["string", "integer"])
    end

    it "selects enum" do
      expect(model.fields(:enum).map(&:name)).to eq(["enum"])
    end

    it "selects associations" do
      expect(model.fields(:association).map(&:name)).to eq(["belongs_to", "has_one", "has_many"])
    end

    it "selects attachments" do
      expect(model.fields(:attachment).map(&:name)).to eq(["has_one_attached", "has_many_attached"])
    end

    it "selects belongs_to" do
      expect(model.fields(:belongs_to).map(&:name)).to eq(["belongs_to"])
    end

    it "selects has_one" do
      expect(model.fields(:has_one).map(&:name)).to eq(["has_one"])
    end

    it "selects has_many" do
      expect(model.fields(:has_many).map(&:name)).to eq(["has_many"])
    end

    it "selects has_one_attached" do
      expect(model.fields(:has_one_attached).map(&:name)).to eq(["has_one_attached"])
    end

    it "selects has_many_attached" do
      expect(model.fields(:has_many_attached).map(&:name)).to eq(["has_many_attached"])
    end

    it "selects string" do
      expect(model.fields(:string).map(&:name)).to eq(["string"])
    end

    it "selects integer" do
      expect(model.fields(:integer).map(&:name)).to eq(["integer"])
    end
  end
end
