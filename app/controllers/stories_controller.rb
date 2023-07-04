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
 @story = find_or_initialize_story
 return redirect_to stories_path, alert: "Story not found" unless @story

 return redirect_to stories_path, alert: "Story not saved" unless save_story_and_flag

 if flag_already_exists?
   redirect_to story_path(@story), alert: "You have already flagged this story"
 else
   redirect_to story_path(@story)
 end
end

private

def find_or_initialize_story
 story_details = HackerNewsApi.get_story_details(params[:id])
 return if story_details.blank?

 story = Story.find_or_initialize_by(story_id: params[:id])
 if story.new_record?
   story.title = story_details['title']
   story.url = story_details['url']
   story.user_id = current_user.id
   story.save
 end
 story
end

def save_story_and_flag
 return unless @story.persisted?

 @flag = current_user.flags.build(story: @story)
 @flag.save
end

def flag_already_exists?
 @flag.errors[:user].include?("has already been taken")
end

def flagged
  @flagged_stories = Story.joins(:flags).distinct
end
end
