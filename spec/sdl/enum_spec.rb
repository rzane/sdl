RSpec.describe SDL::Enum do
  subject(:enum) {
    SDL::Enum.new(:status, foo: :bar)
  }

  it "has a name" do
    expect(enum.name).to eq("status")
  end

  it "has options" do
    expect(enum.options).to eq(foo: :bar)
  end

  it "has values" do
    expect(enum.values).to eq([])
  end

  it "accepts values" do
    enum.value "ACCEPTED"
    expect(enum.values).to eq(["ACCEPTED"])
  end
end
