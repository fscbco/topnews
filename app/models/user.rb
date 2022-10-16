class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
        has_many :likes, dependent: :destroy

    def full_name 
      "#{first_name} "  +  " #{last_name}"
    end
end




