json.extract! flagged_story, :id, :title, :by, :name, :external_id, :score, :created_at, :updated_at
json.url flagged_story_url(flagged_story, format: :json)
