require 'rails_helper'

describe User do
  context "creating a new user" do
    it "is valid with valid attributes" do
      expect(
        User.new(
          first_name: "John",
          last_name: "Doe",
          email: "john@doe.com",
          password: "dlk2j213jf"
        )
      ).to be_valid
    end

    it "is invalid without a first name" do
      expect(
        User.new(
          first_name: "",
          last_name: "Doe",
          email: "john@doe.com",
          password: "dlk2j213jf"
        )
      ).to_not be_valid
    end

    it "is invalid without a last name" do
      expect(
        User.new(
          first_name: "John",
          last_name: "",
          email: "john@doe.com",
          password: "dlk2j213jf"
        )
      ).to_not be_valid
    end

    it "is invalid without an email address" do
      expect(
        User.new(
          first_name: "John",
          last_name: "Doe",
          email: "",
          password: "dlk2j213jf"
        )
      ).to_not be_valid
    end

    it "is invalid without a password" do
      expect(
        User.new(
          first_name: "John",
          last_name: "Doe",
          email: "john@doe.com",
          password: ""
        )
      ).to_not be_valid
    end

  end
end
