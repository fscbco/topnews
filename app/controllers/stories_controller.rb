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

   if flag_already_exists?
     return redirect_to story_path(@story), alert: "You have already flagged this story"
   end

   unless save_story_and_flag
     return redirect_to stories_path, alert: "Flag not saved!"
   end

   redirect_to story_path(@story)
 end

 def flagged
   @flagged_stories = Story.joins(:flags).distinct
   @flagged_stories_data = @flagged_stories.map do |story|
     {
       title: story.title,
       url: story.url,
       flags: story.flags.map do |flag|
         {
           user: {
             first_name: flag.user.first_name,
             last_name: flag.user.last_name
           }
         }
       end.uniq
     }
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
   current_user.flags.exists?(story_id: @story.id)
 end
end
