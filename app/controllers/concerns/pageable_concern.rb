module PageableConcern
  extend ActiveSupport::Concern

  def items_per_page
    # In case we want to make this customizable from the page later.
    params[:items_per_page] || Kaminari.config.default_per_page
  end
end
