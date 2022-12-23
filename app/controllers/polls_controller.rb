class PollsController < ApplicationController
  before_action :authenticate_user!
  # See #render_unallowed_redirect_path_error notes.
  before_action :render_unallowed_redirect_path_error, except: :feeds_poll, unless: -> { helpers.allowable_redirect_path? }

  def feeds
    respond_to do |format|
      format.html
    end
  end

  def feeds_poll
    data = {
      running: helpers.feed_update_running?,
    }
    render json: data.to_json, status: :ok
  end

  private

  def render_unallowed_redirect_path_error
    # TODO: In the real world, we'd have an ErrorsController and raise a custom error
    # (e.g. UnallowedRedirectPath) that would route to ErrorsController#unallowed_redirect_path;
    # but, for the purposes of this challenge:
    # TODO: Log any other information we think may be helpful here e.g. IP, etc.
    Rails.logger.error("params[:redirect_path] was not in the allowed list: #{params[:redirect_path]}")
    render html: "<span style='color:#cc0000;'>Oops! I'm not sure where to go from here, are you a bad guy? >:^/)</span>".html_safe
  end
end
