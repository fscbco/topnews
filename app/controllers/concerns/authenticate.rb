module Authenticate
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request
  end

  private

  def authenticate_request
    @current_user = decoded_user
    render_unauthorized unless @current_user
  end

  def decoded_user
    return nil unless token
    
    decoded = JsonWebToken.decode(token)
    User.find(decoded[:user_id])
  rescue JWT::DecodeError
    log_error("Invalid token")
    nil
  rescue ActiveRecord::RecordNotFound
    log_error("User not found")
    nil
  rescue StandardError => e
    log_error("Unexpected authentication error: #{e.message}")
    nil
  end

  def token
    header = request.headers['Authorization']
    header.split(' ').last if header
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def log_error(message)
    Rails.logger.error("Authentication error: #{message}")
  end
end