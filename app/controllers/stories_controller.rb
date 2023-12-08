class StoriesController < ApplicationController

  def index
    validated_params = StoriesIndexContract.new.call(request.params)
    if validated_params.errors.empty?
      filtered = Story.includes(:users).where(top: true)
      filtered = filtered.joins(:users) if params.dig("filter","liked")
      @pagy, @stories = pagy(filtered.all, items: 20) 
    else
      format_errors_for_flash(validated_params)
    end
  end

end
