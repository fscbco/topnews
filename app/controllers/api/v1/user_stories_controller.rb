module Api
  module V1
    class UserStoriesController < BaseController
      include Authenticate

      before_action :authenticate_request
      before_action :set_user_story, only: [:destroy]

      def index
        user_stories = @current_user.user_stories
        render json: user_stories, include: { story: { only: [:id, :title, :url, :hn_id] } }
      rescue StandardError => e
        render json: { error: "An unexpected error occurred" }, status: :internal_server_error
      end

      def create
        story = find_or_create_story
        user_story = @current_user.user_stories.find_or_create_by(story: story)

        if user_story.persisted?
          render json: user_story, include: :story, status: :created
        else
          render json: user_story.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @user_story
          @user_story.destroy
          render json: { message: 'User story successfully deleted' }, status: :ok
        else
          render json: { error: 'User story not found' }, status: :not_found
        end
      end

      private

      def set_user_story
        @user_story = @current_user.user_stories.find_by(id: params[:id])
      end

      def find_or_create_story
        Story.find_or_create_by(hn_id: params[:story_id]) do |s|
          s.title = params[:title]
          s.url = params[:url]
        end
      end

    end
  end
end