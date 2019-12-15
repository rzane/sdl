require "sdl/association"

RSpec.describe SDL::Association::BelongsTo do
  subject(:association) {
    described_class.new(:user)
  }

  it "is an association" do
    expect(association).to be_an(SDL::Association)
  end

  it "has a name" do
    expect(association.name).to eq("user")
  end

  it "has a type" do
    expect(association.type).to eq(:belongs_to)
  end

  it "has an inferred model_name" do
    expect(association.model_name).to eq("user")
  end

  it "accepts a custom model_name" do
    association = described_class.new(:user, model_name: :person)
    expect(association.model_name).to eq("person")
  end

  it "accepts an option for required" do
    expect(described_class.new(:user, required: true)).to be_required
  end

  it "accepts an option for unique" do
    expect(described_class.new(:user, unique: true)).to be_unique
  end

  it "accepts an option for index" do
    expect(described_class.new(:user, index: true)).to be_index
  end

  it "accepts an option for foreign_key" do
    expect(described_class.new(:user, foreign_key: true)).to be_foreign_key
  end

  it "accepts additional options" do
    association = described_class.new(:user, foo: "bar")
    expect(association.options).to eq(foo: "bar")
  end
end
