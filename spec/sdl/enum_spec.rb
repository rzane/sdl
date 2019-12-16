RSpec.describe SDL::Enum do
  subject(:enum) { build }

  it "has a name" do
    expect(enum.name).to eq("value")
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
  end

  def build(**opts)
    SDL::Enum.new(:value, **opts)
  end
end
