class StorySave < ApplicationRecord
  belongs_to :user
  belongs_to :story
  validates :user_id, uniqueness: { scope: :api_id }
end
