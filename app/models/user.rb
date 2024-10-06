# file: user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :starred_stories, dependent: :destroy
  has_many :stories, through: :starred_stories

  validates :email, presence: true

  def admin?
    admin
  end
end