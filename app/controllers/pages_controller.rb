class PagesController < ApplicationController
	before_action :authenticate_user!

	def home
		if Story.count == 0
			Story.ingest
		end

		@stories = Story.order("created_at desc").limit(10)
		likes_query = Like.where(story_id: @stories.map{ |s| s.hn_id })
		@users = User.find(likes_query.map{ |l| l.user_id }).map{ |u| [u.id, "#{u.first_name} #{u.last_name}"]}.to_h
		@likes = likes_query.group_by{ |l| l[:story_id] }
		@you_like = likes_query.where(user_id: current_user.id).map{ |l| l[:story_id] }
	end

	def like
		Like.create(story_id: params["id"], user_id: current_user.id)
		redirect_to root_path
	end
end
