require "sdl/attachment"

RSpec.describe SDL::Attachment::HasOne do
  subject(:attachment) {
    described_class.new(:logo, foo: :bar)
  }

  it "has a name" do
    expect(attachment.name).to eq("logo")
  end

  it "has a type" do
    expect(attachment.type).to eq(:has_one_attached)
  end

  it "has options" do
    expect(attachment.options).to eq(foo: :bar)
  end
end
