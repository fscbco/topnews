# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  story_id   :integer
#  user_id    :bigint
#
# Indexes
#
#  index_likes_on_user_id               (user_id)
#  index_likes_on_user_id_and_story_id  (user_id,story_id) UNIQUE
#
class Like < ApplicationRecord
  belongs_to :user

  def user_name
    user.full_name
  end
end
