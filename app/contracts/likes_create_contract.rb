class LikesCreateContract < Dry::Validation::Contract

  option :user

  params do 
    required(:story_id).filled(:integer)
  end

  rule(:story_id) do 
    key.failure('is unrecognized') if Story.where(id: value).empty?
    key.failure('is a duplicate') unless Like.where(story_id: value, user: user).empty?
  end
end
