class Headline < ApplicationRecord
  validates :external_id, uniqueness: true
  validates :url, presence: {message: "headline must have a URL"}
  validates :title, presence: {message: "headline must have a title"}

  has_many :user_favorite

  def add_favorite
    self.increment!(:favorites)
    self.save!
  end

  def user_who_favorited(user_id)
    @user = User.find(user_id)
    user_favorite = UserFavorite.new(
      user: @user,
      headline: self
    )
    user_favorite.save! if user_favorite.valid?
  end
end
