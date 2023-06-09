json.array! @stories do |story|
  json.id story.id
  json.title story.title
  json.text story.text
  json.url story.url
  json.score story.score
  json.by story.by
  json.descendants story.descendants
  json.time story.time
  json.created_at story.created_at
  json.updated_at story.updated_at
  json.liked_by @story_likes[story.id] || {}
end