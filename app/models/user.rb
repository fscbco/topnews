class User < ApplicationRecord
  include RecommendedFeedItemConcern

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :feeds, join_table: :user_feeds

  def full_name
    "#{first_name} #{last_name}"
  end
end
