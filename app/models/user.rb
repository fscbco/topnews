class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :stories, through: :favorites
         
  before_create :placeholder_first_name

  private
  
  def placeholder_first_name
    unless first_name
      self.first_name = email.split("@").first
    end
  end
end
