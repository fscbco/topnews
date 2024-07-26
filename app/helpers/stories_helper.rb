# frozen_string_literal: true

# app/helpers/stories_helper.rb
# Description: This helper module is used to display a star next to a post if a user has favorited it.
module StoriesHelper
  USER_STAR = '🌟'
  OTHER_STAR = '★'
  NO_STAR = '☆'

  def display_star(post_id)
    if @user_faves.include?(post_id) 
      USER_STAR
    elsif @other_faves.include?(post_id)
      OTHER_STAR
    else
      NO_STAR
    end
  end
end
