class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_page, only: [:show, :upvote, :downvote]

  PAGE_LIST_SIZE = 11

  def index
    pages_list = pages_fetch.list.first(PAGE_LIST_SIZE)
    if Page.exists? && (pages_list - Page.last(500).pluck(:page_id)).empty?
    else
      pages_list.each do |page_id|
        page = pages_fetch.get(page_id)
        Page.find_or_initialize_by(page_id: page['id'])
          .update(title: page['title'])
      end
    end
    @pages = Page.last(PAGE_LIST_SIZE)
  end

  def show
    @page_h = pages_fetch.get(@page.page_id)
  end

  def upvote
    @page.stars.find_or_create_by(user: current_user)
    respond_to do |format|
      format.html { redirect_to @page }
      format.turbo_stream
    end
  end

  def downvote
    @page.stars.destroy_by(user: current_user)
    respond_to do |format|
      format.html { redirect_to @page }
      format.turbo_stream
    end
  end

  private

  def pages_fetch
    @pages_fetch ||= PagesFetch.new
  end

  def set_page
    @page = Page.find(params[:id])
  end
end
