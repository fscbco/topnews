module Api
  module V1
    class BaseController < ActionController::Base
      protect_from_forgery with: :null_session
      before_action :set_csrf_cookie

      private

      def set_csrf_cookie
        cookies['CSRF-TOKEN'] = form_authenticity_token
      end
    end
  end
end