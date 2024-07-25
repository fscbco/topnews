class Star < ApplicationRecord

  include ActionView::RecordIdentifier

  belongs_to :user
  belongs_to :page, counter_cache: :votes

  validates :page_id, uniqueness: { scope: :user_id }

  after_create_commit -> {
    broadcast_update_later_to "votes",
      target: "#{dom_id(self.page)}_votes_count",
      html: self.page.votes,
      locals: { star: self }
  }

  after_destroy_commit -> {
    broadcast_update_later_to "votes",
      target: "#{dom_id(self.page)}_votes_count",
      html: self.page.votes,
      locals: { star: nil }
  }
end
