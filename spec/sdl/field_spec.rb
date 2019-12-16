RSpec.describe SDL::Field do
  SDL::TYPES.each do |type|
    it "recognizes a field with type :#{type}" do
      klass = Class.new(SDL::Field) { attr_accessor :type }
      field = klass.new(:foo)
      field.type = type

      expect(field).to send("be_#{type}")

      (SDL::TYPES - [type]).each do |other_type|
        expect(field).not_to send("be_#{other_type}")
      end
    end
  end
end
