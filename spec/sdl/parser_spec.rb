require "sdl/parser"

RSpec.describe SDL::Parser do
  subject(:parser) { SDL::Parser.new }

  it "parses a field with defaults" do
    field = parser.parse("foo")
    expect(field.name).to eq("foo")
    expect(field.type).to eq(:string)
    expect(field).not_to be_required
    expect(field).not_to be_unique
    expect(field.default).to be_nil
    expect(field.limit).to be_nil
    expect(field.precision).to be_nil
    expect(field.scale).to be_nil
  end

  it "parses a string" do
    field = parser.parse("foo:string")
    expect(field.type).to eq(:string)
  end

  it "parses a string with a limit" do
    field = parser.parse("foo:string{5}")
    expect(field.type).to eq(:string)
    expect(field.limit).to eq(5)
  end

  it "parses a decimal" do
    field = parser.parse("foo:decimal")
    expect(field.type).to eq(:decimal)
  end

  it "parses a with scale and precision" do
    field = parser.parse("foo:decimal{10,2}")
    expect(field.type).to eq(:decimal)
    expect(field.precision).to eq(10)
    expect(field.scale).to eq(2)
  end

  it "parses a required field" do
    field = parser.parse("foo:required")
    expect(field).to be_required
  end

  it "parses a unique field" do
    field = parser.parse("foo:unique")
    expect(field).to be_unique
  end

  it "parses a default value" do
    field = parser.parse("foo:default{blah}")
    expect(field.default).to eq("blah")
  end

  it "parses an belongs_to association with a different model name" do
    field = parser.parse("foo:belongs_to")
    expect(field).to be_a(SDL::Association::BelongsTo)
    expect(field.name).to eq("foo")
    expect(field.model_name).to eq("foo")
  end

  it "parses an belongs_to association with a different model name" do
    field = parser.parse("foo:belongs_to{user}")
    expect(field).to be_a(SDL::Association::BelongsTo)
    expect(field.name).to eq("foo")
    expect(field.model_name).to eq("user")
  end
end
