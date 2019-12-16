RSpec.describe SDL::Attachment::HasMany do
  subject(:attachment) {
    described_class.new(:logo, foo: :bar)
  }

  it "is an attachment" do
    expect(attachment).to be_an(SDL::Attachment)
    expect(attachment).to be_attachment
  end

  it "has a name" do
    expect(attachment.name).to eq("logo")
    expect(attachment.name).to be_a(SDL::Name)
  end

  it "has a type" do
    expect(attachment.type).to eq(:has_many_attached)
  end

  it "has a type_name" do
    expect(attachment.type_name).to eq("has_many_attached")
    expect(attachment.type_name).to be_a(SDL::Name)
  end

  it "has options" do
    expect(attachment.options).to eq(foo: :bar)
  end
end
