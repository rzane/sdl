RSpec.describe SDL::Parser do
  subject(:parser) { SDL::Parser.new }

  it "parses with defaults" do
    field = parser.parse("value")
    expect(field.name).to eq("value")
    expect(field.type).to be(:string)
    expect(field.default).to be_nil
    expect(field.limit).to be_nil
    expect(field.precision).to be_nil
    expect(field.scale).to be_nil
    expect(field).not_to be_nullable
    expect(field).not_to be_unique
    expect(field).not_to be_index
  end

  SDL::SCALAR_TYPES.each do |type|
    it "parses #{type}" do
      field = parser.parse("value:#{type}")
      expect(field.type).to be(type)
    end
  end

  %i[string text binary integer].each do |type|
    it "parses #{type} with a limit" do
      field = parser.parse("value:#{type}{5}")
      expect(field.type).to be(type)
      expect(field.limit).to eq(5)
    end
  end

  {comma: ",", period: ".", hypen: "-"}.each do |sep_name, sep|
    it "parses decimal with precision and scale separated by #{sep_name}" do
      field = parser.parse("value:decimal{10#{sep}2}")
      expect(field.type).to be(:decimal)
      expect(field.precision).to eq(10)
      expect(field.scale).to eq(2)
    end
  end

  %i[unique nullable index].each do |modifier|
    it "parses #{modifier}" do
      expect(parser.parse("value:#{modifier}")).to send("be_#{modifier}")
    end
  end

  {string: "blah", integer: 1, float: 1.5, boolean: true}.each do |type, default|
    it "parses default #{type}" do
      field = parser.parse("value:#{type}:default{#{default}}")
      expect(field.type).to be(type)
      expect(field.default).to eq(default)
    end
  end

  {comma: ",", period: ".", hypen: "-"}.each do |sep_name, sep|
    it "parses enum with values separated by #{sep_name}" do
      field = parser.parse("status:enum{accepted#{sep}rejected}")
      expect(field).to be_a(SDL::Enum)
      expect(field.name).to eq("status")
      expect(field.values).to eq(["accepted", "rejected"])
    end
  end

  it "parses belongs_to" do
    field = parser.parse("user:belongs_to")
    expect(field).to be_a(SDL::Association::BelongsTo)
    expect(field.name).to eq("user")
    expect(field.model_name).to eq("user")
  end

  it "parses belongs_to with model name" do
    field = parser.parse("user:belongs_to{person}")
    expect(field).to be_a(SDL::Association::BelongsTo)
    expect(field.name).to eq("user")
    expect(field.model_name).to eq("person")
  end

  it "parses belongs_to with foreign_key" do
    field = parser.parse("user:belongs_to:foreign_key")
    expect(field).to be_foreign_key
  end

  it "parses has_one" do
    field = parser.parse("user:has_one")
    expect(field).to be_a(SDL::Association::HasOne)
    expect(field.name).to eq("user")
    expect(field.model_name).to eq("user")
  end

  it "parses has_one with model name" do
    field = parser.parse("user:has_one{person}")
    expect(field).to be_a(SDL::Association::HasOne)
    expect(field.name).to eq("user")
    expect(field.model_name).to eq("person")
  end

  it "parses has_many" do
    field = parser.parse("users:has_many")
    expect(field).to be_a(SDL::Association::HasMany)
    expect(field.name).to eq("users")
    expect(field.model_name).to eq("user")
  end

  it "parses has_many with model name" do
    field = parser.parse("users:has_many{person}")
    expect(field).to be_a(SDL::Association::HasMany)
    expect(field.name).to eq("users")
    expect(field.model_name).to eq("person")
  end

  it "parses has_one_attached" do
    field = parser.parse("logo:has_one_attached")
    expect(field).to be_a(SDL::Attachment::HasOne)
    expect(field.name).to eq("logo")
  end

  it "parses has_many_attached" do
    field = parser.parse("logos:has_many_attached")
    expect(field).to be_a(SDL::Attachment::HasMany)
    expect(field.name).to eq("logos")
  end

  it "raises an error when given an invalid directive" do
    expect { parser.parse("value:trash") }.to raise_error(
      SDL::ParseError,
      "Unrecognized parameter: trash"
    )
  end
end
