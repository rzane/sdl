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
    expect(model.fields).to be_a(SDL::Fields)
  end

  it "accepts a field" do
    model.field :name, :string
    expect(model.fields.first).to be_an(SDL::Field)
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
end
