RSpec.describe SDL::Attribute do
  subject(:field) { build }

  it "has a name" do
    expect(field.name).to eq("value")
  end

  it "has a type" do
    expect(field.type).to be(:string)
  end

  it "accepts a default" do
    field = build(default: 5)
    expect(field.default).to eq(5)
  end

  it "accepts a limit" do
    field = build(limit: 5)
    expect(field.limit).to eq(5)
  end

  it "accepts a precision" do
    field = build(precision: 5)
    expect(field.precision).to eq(5)
  end

  it "accepts a scale" do
    field = build(scale: 5)
    expect(field.scale).to eq(5)
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

  def build(**opts)
    SDL::Attribute.new(:value, :string, **opts)
  end
end
