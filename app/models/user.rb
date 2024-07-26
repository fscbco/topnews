class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, foreign_key: :post_author_id
  has_many :favorites
  has_many :favorited_posts, through: :favorites, source: :post
end
