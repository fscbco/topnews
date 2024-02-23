class Story
  vattr_initialize [:id, :title, :url, :by] 

  def likes
    Like.where(story_id: id)
  end
end
