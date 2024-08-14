module Api
  module V1
    class UserStoriesController < BaseController
      include Authenticate

      before_action :authenticate_request
      before_action :set_user_story, only: [:destroy]

      def index
        grouped_stories = Story.joins(:user_stories, :users)
                               .select('stories.*, array_agg(DISTINCT users.email) as user_emails')
                               .group('stories.id')
                               .order('stories.created_at DESC')

        render json: {
          current_user_email: @current_user.email,
          stories: grouped_stories.map { |story| story_json(story) }
        }
      rescue StandardError => e
        render_error(e, :internal_server_error)
      end

      def create
        story = find_or_create_story
        user_story = UserStory.find_or_create_by(story: story, user: @current_user)

        if user_story.persisted?
          render json: user_story, include: :story, status: :created
        else
          render_error(user_story.errors, :unprocessable_entity)
        end
      rescue ActiveRecord::RecordInvalid => e
        render_error(e.record.errors, :unprocessable_entity)
      end


      def destroy
        if @user_story
          @user_story.destroy
          render json: { message: 'User story successfully deleted' }, status: :ok
        else
          render_error('User story not found', :not_found)
        end
      end

      private

      def set_user_story
        @user_story = @current_user.user_stories.find_by(story_id: params[:id])
      end

      def find_or_create_story
        Story.find_or_create_by!(hn_id: params[:story_id]) do |s|
          s.title = params[:title]
          s.url = params[:url]
        end
      rescue ActiveRecord::RecordInvalid => e
        raise e
      end

      def story_json(story)
        {
          id: story.id,
          title: story.title,
          url: story.url,
          hn_id: story.hn_id,
          user_emails: story.user_emails,
          current_user_starred: story.user_emails.include?(@current_user.email)
        }
      end

      def render_error(error, status)
        error_message = error.is_a?(ActiveModel::Errors) ? error.full_messages.join(', ') : error.to_s
        render json: { error: error_message }, status: status
      end
    end
  end
end