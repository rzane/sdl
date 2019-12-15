RSpec.describe SDL::Fields do
  let(:string) { SDL::Field.new(:string, :string) }
  let(:integer) { SDL::Field.new(:integer, :integer) }
  let(:enum) { SDL::Enum.new(:enum) }
  let(:belongs_to) { SDL::Association::BelongsTo.new(:belongs_to) }
  let(:has_one) { SDL::Association::HasOne.new(:has_one) }
  let(:has_many) { SDL::Association::HasMany.new(:has_many) }
  let(:has_one_attached) { SDL::Attachment::HasOne.new(:has_one_attached) }
  let(:has_many_attached) { SDL::Attachment::HasMany.new(:has_many_attached) }

  subject(:fields) {
    SDL::Fields.new([
      string,
      integer,
      enum,
      belongs_to,
      has_one,
      has_many,
      has_one_attached,
      has_many_attached
    ])
  }

  it "retrieves a field by index" do
    expect(fields[1]).to eq(integer)
  end

  it "selects attributes" do
    expect(fields.attributes).to eq([string, integer])
  end

  it "selects enums" do
    expect(fields.enums).to eq([enum])
  end

  it "selects associations" do
    expect(fields.associations).to eq([belongs_to, has_one, has_many])
  end

  it "selects attachments" do
    expect(fields.attachments).to eq([has_one_attached, has_many_attached])
  end

  it "selects belongs_to" do
    expect(fields.belongs_to).to eq([belongs_to])
  end

  it "selects has_one" do
    expect(fields.has_one).to eq([has_one])
  end

  it "selects has_many" do
    expect(fields.has_many).to eq([has_many])
  end

  it "selects has_one_attached" do
    expect(fields.has_one_attached).to eq([has_one_attached])
  end

  it "selects has_many_attached" do
    expect(fields.has_many_attached).to eq([has_many_attached])
  end

  it "selects string" do
    expect(fields.string).to eq([string])
  end

  it "selects integer" do
    expect(fields.integer).to eq([integer])
  end
end
