class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :flags
  has_many :flagged_stories, through: :flags, source: :story

  def name
    first_name + " " + last_name
  end
end
