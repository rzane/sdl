require "sdl/name"

RSpec.describe SDL::Name do
  let(:name) { described_class.new("email_address") }

  describe "#table" do
    specify { expect(name.table).to eq("email_addresses") }
  end

  describe "#param" do
    specify { expect(name.param).to eq("email-address") }
  end

  describe "#params" do
    specify { expect(name.params).to eq("email-addresses") }
  end

  describe "#snake" do
    specify { expect(name.snake).to eq("email_address") }
  end

  describe "#snakes" do
    specify { expect(name.snakes).to eq("email_addresses") }
  end

  describe "#scream" do
    specify { expect(name.scream).to eq("EMAIL_ADDRESS") }
  end

  describe "#screams" do
    specify { expect(name.screams).to eq("EMAIL_ADDRESSES") }
  end

  describe "#camel" do
    specify { expect(name.camel).to eq("emailAddress") }
  end

  describe "#camels" do
    specify { expect(name.camels).to eq("emailAddresses") }
  end

  describe "#entity" do
    specify { expect(name.entity).to eq("EmailAddress") }
  end

  describe "#entities" do
    specify { expect(name.entities).to eq("EmailAddresses") }
  end

  describe "#title" do
    specify { expect(name.title).to eq("Email Address") }
  end

  describe "#titles" do
    specify { expect(name.titles).to eq("Email Addresses") }
  end

  describe "#label" do
    specify { expect(name.label).to eq("Email address") }
  end

  describe "#labels" do
    specify { expect(name.labels).to eq("Email addresses") }
  end

  describe "#description" do
    specify { expect(name.description).to eq("email address") }
  end

  describe "#descriptions" do
    specify { expect(name.descriptions).to eq("email addresses") }
  end
end
