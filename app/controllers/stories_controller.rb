class StoriesController < ApplicationController
 def index
  all_stories = HackerNewsApi.get_all_stories
  sorted_stories = all_stories.sort.reverse
  @top_stories = sorted_stories.take(10)
 end

 def show
  @story = Story.find_by(id: params[:id])

  if @story
    render :show
  else
    redirect_to stories_path, alert: "Story not found"
  end
end

def flag
 @story_id = params[:id]
 story_details = HackerNewsApi.get_story_details(@story_id)

 if story_details.present?
   @story = Story.find_or_initialize_by(story_id: @story_id)

   if @story.new_record?
     @story.title = story_details['title']
     @story.url = story_details['url']
     @story.flagged = true
     @story.flagged_by = current_user.id
     @story.user_id = current_user.id
     @story.save
   end

   if @story.persisted?
     redirect_to story_path(@story)
   else
     puts @story.errors.full_messages
     redirect_to stories_path, alert: "Story not flagged"
   end
 else
   redirect_to stories_path, alert: "Story not found"
 end
end

def flagged
  @flagged_stories = Story.joins(:flags).distinct
end
end
