# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "rails_helper"

describe User do
  let(:attrs) do
    {first_name: :foo, last_name: :bar, email: "f@b.c", password: "foobar123"}
  end

  context "creating a new user" do
    it "should have first, last, email" do
      expect { User.create(attrs) }.to change { User.count }.by(1)
    end

    it "should require a password" do
      expect(User.new(attrs.except(:password))).to be_invalid
    end
  end

  describe "#full_name" do
    it "should be constructed from first/last name" do
      full_name = User.new(attrs).full_name
      expect(full_name).to eq "foo bar"
    end
  end
end
