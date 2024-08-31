class User < ApplicationRecord
  has_and_belongs_to_many :flagged_stories, validate: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email, case_sensitive: false

  def full_name
    "#{first_name} #{last_name}"
  end
end
