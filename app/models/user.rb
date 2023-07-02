class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :stars
  has_many :stories, through: :stars

  def familiar_name
    return "#{first_name} #{last_name.first}."
  end
end
