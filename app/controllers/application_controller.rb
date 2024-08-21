class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ActionView::Helpers::TagHelper
  include ActionView::Context
  include Pagy::Backend

  def render_flash
    turbo_stream.update "flash", partial: "layouts/flash"
  end

  def create_flash(type, message)
    flash.now[type] = message
    render_flash
  end
end
