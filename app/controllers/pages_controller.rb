class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    pages_list = pages_fetch.list
    if Page.exists? && (pages_list - Page.last(500).pluck(:page_id)).empty?
    else
      pages_list.each do |page_id|
        page = pages_fetch.get(page_id)
        Page.find_or_initialize_by(page_id: page['id'])
          .update(title: page['title'])
      end
    end
    @pages = Page.last(10)
  end

  def show
    @page = Page.find(params[:id])
    @page_h = pages_fetch.get(@page.page_id)
  end

  # def upvote
  #   @page.increment(:votes)
  #   @page.save
  # end

  # def downvote
  #   @page.decrement(:votes)
  #   @page.save
  # end

  private

  def pages_fetch
    @pages_fetch ||= PagesFetch.new
  end
end
