class StoriesController < ApplicationController

  def index
    validated_params = StoriesIndexContract.new.call(request.params)
    if validated_params.errors.empty?
      filtered = Story.includes(:users).where(top: true).order(created_at: :desc)
      filtered = filtered.joins(:users) if validated_params.to_h.dig(:filter,:liked)
      @pagy, @stories = pagy(filtered.all, items: 20) 
    else
      format_errors_for_flash(validated_params)
    end
  end

end
