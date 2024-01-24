require 'spec-helper'

RSpec.describe Ramlethal do
  describe "validations" do
    it "requires a name" do
      ram = Ramlethal.new(email: "johndoe@example.com")
      expect(ram.valid?).to be_falsey
      expect(ram.errors[:name]).to include("can't be blank")
    end

    it "requires a unique email" do
      user1 = User.create(name: "John Doe", email: "johndoe@example.com")
      user2 = User.new(name: "Jane Doe", email: "johndoe@example.com")
      expect(user2.valid?).to be_falsey
      expect(user2.errors[:email]).to include("has already been taken")
    end
  end
end