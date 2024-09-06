class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Has many stars
  has_many :stars, dependent: :destroy
  has_many :starred_stories, through: :stars, source: :story
    
end
