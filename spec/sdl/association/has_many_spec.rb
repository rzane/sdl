require "sdl/association"

RSpec.describe SDL::Association::HasMany do
  subject(:association) {
    described_class.new(:users)
  }

  it "is an association" do
    expect(association).to be_an(SDL::Association)
  end

  it "has a name" do
    expect(association.name).to eq("users")
  end

  it "has a type" do
    expect(association.type).to eq(:has_many)
  end

  it "has an inferred model_name" do
    expect(association.model_name).to eq("user")
  end

  it "accepts a custom model_name" do
    association = described_class.new(:users, model_name: :person)
    expect(association.model_name).to eq("person")
  end

  it "accepts additional options" do
    association = described_class.new(:users, foo: "bar")
    expect(association.options).to eq(foo: "bar")
  end
end
