class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :stars
  has_many :starred_posts, class_name: 'Post', foreign_key: :post_id, through: :stars, source: :post

  validates :first_name, presence: true
  validates :last_name, presence: true
end
