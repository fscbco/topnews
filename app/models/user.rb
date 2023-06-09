class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  has_many :likes, dependent: :destroy

  def update_mutable(user_input)
    self.first_name = user_input[:first_name] if user_input.key?(:first_name)
    self.last_name = user_input[:last_name] if user_input.key?(:last_name)
    self.email = user_input[:email] if user_input.key?(:email)
    self.save!
    self
  end
  def self.get_first_names(user_ids)
    users = {}
    User.where(id: user_ids).each do |user|
      users[user.id] = user.first_name
    end
    users
  end
end
