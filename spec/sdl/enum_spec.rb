RSpec.describe SDL::Enum do
  subject(:enum) { build }

  it "is an enum" do
    expect(enum).to be_enum
  end

  it "has a name" do
    expect(enum.name).to eq("value")
    expect(enum.name).to be_a(SDL::Name)
  end

  it "has a type" do
    expect(enum.type).to eq(:enum)
  end

  it "has options" do
    enum = build(foo: :bar)
    expect(enum.options).to eq(foo: :bar)
  end

  it "has values" do
    enum = build(values: [:accepted, :rejected])
    expect(enum.values).to eq(["accepted", "rejected"])
    expect(enum.values.first).to be_a(SDL::Name)
  end

  it "can be required" do
    expect(build(required: true)).to be_required
  end

  it "can be unique" do
    expect(build(unique: true)).to be_unique
  end

  it "can be indexed" do
    expect(build(index: true)).to be_index
  end

  it "can have a default" do
    enum = build(default: :accepted)
    expect(enum.default).to eq("accepted")
    expect(enum.default).to be_a(SDL::Name)
  end

  it "has a type_name" do
    expect(enum.type_name).to eq("enum")
    expect(enum.type_name).to be_a(SDL::Name)
  end

  it "has a column_name" do
    expect(enum.column_name).to eq("value")
    expect(enum.column_name).to be_a(SDL::Name)
  end

  def build(**opts)
    SDL::Enum.new(:value, **opts)
  end
end
