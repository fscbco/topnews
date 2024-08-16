class Article < ApplicationRecord
  self.inheritance_column = :_type

  has_many :user_articles
  has_many :users, through: :user_articles
end
