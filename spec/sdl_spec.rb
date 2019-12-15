RSpec.describe SDL do
  it "has a version number" do
    expect(SDL::VERSION).not_to be nil
  end

  describe ".define" do
    let(:schema) {
      SDL.define do
        model :user do
          field :name, :string
          field :age, :integer
        end
      end
    }

    it "defines a schema" do
      expect(schema).to be_a(SDL::Schema)
      expect(schema.models[0].name).to eq("user")
      expect(schema.models[0].fields[0].name).to eq("name")
      expect(schema.models[0].fields[0].type).to be(:string)
      expect(schema.models[0].fields[1].name).to eq("age")
      expect(schema.models[0].fields[1].type).to be(:integer)
    end
  end

  describe ".parse" do
    let(:model) { SDL.parse("user", ["name:string", "age:integer"]) }

    it "builds a model from arguments" do
      expect(model).to be_a(SDL::Model)
      expect(model.name).to eq("user")
      expect(model.fields[0].name).to eq("name")
      expect(model.fields[0].type).to be(:string)
      expect(model.fields[1].name).to eq("age")
      expect(model.fields[1].type).to be(:integer)
    end
  end

  describe ".load_file" do
    let(:fixture) { File.join(__dir__, "fixtures", "schema.rb") }
    let(:schema) { SDL.load_file(fixture) }

    it "loads a schema file" do
      expect(schema).to be_a(SDL::Schema)
      expect(schema.models[0].name).to eq("user")
      expect(schema.models[0].fields[0].name).to eq("name")
      expect(schema.models[0].fields[0].type).to be(:string)
      expect(schema.models[0].fields[1].name).to eq("age")
      expect(schema.models[0].fields[1].type).to be(:integer)
    end
  end
end
