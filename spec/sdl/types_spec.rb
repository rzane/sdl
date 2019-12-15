require "sdl/types"

RSpec.describe SDL::Types do
  describe ".scalar" do
    it "is an array" do
      expect(SDL::Types.scalar).to be_an(Array)
    end
  end

  describe ".association" do
    it "is an array" do
      expect(SDL::Types.association).to be_an(Array)
    end
  end

  describe ".attachment" do
    it "is an array" do
      expect(SDL::Types.attachment).to be_an(Array)
    end
  end

  describe ".all" do
    it "is an array" do
      expect(SDL::Types.all).to be_an(Array)
    end
  end

  describe SDL::Types::Queries do
    SDL::Types.all.each do |type|
      it "recognizes a field with type :#{type}" do
        field = double(type: type)
        field.extend SDL::Types::Queries

        expect(field).to send("be_#{type}")

        (SDL::Types.all - [type]).each do |other_type|
          expect(field).not_to send("be_#{other_type}")
        end
      end
    end
  end
end
