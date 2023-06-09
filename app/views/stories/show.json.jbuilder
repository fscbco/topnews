json.(@story, :id, :title, :text, :url, :score, :by, :descendants, :time, :created_at, :updated_at)
json.liked_by @story.liked_by