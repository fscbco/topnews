class User < ApplicationRecord
       devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
       
       devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
       
end
