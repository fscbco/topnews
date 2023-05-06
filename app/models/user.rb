class User < ApplicationRecord

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
