class User < ApplicationRecord
  validates :name, presence: true
  validates :email, uniqueness: true

  has_many :flags
  has_many :flagged_stories, through: :flags, source: :story
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
