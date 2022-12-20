module PagingConcern
  extend ActiveSupport::Concern

  included do
    scope :for_page, ->(order_by, page, items_per_page) {
      order(order_by).offset(offset_for(page, items_per_page)).limit(items_per_page)
    }
  end

  module ClassMethods
    def offset_for(page, items_per_page)
      return 0 unless page.positive?

      (page - 1) * items_per_page
    end
  end
end
