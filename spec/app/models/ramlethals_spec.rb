require '../spec-helper'

RSpec.describe App::Models::Ramlethal do
  describe "validations" do
    it "requires an input as rating_update" do
      ram = Ramlethal.new(rating_update: "foobar")
      expect(ram.valid?).to be_falsey
      expect(ram.errors[:name]).to include("can't be blank")
    end
  end
end