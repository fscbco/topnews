class Story < ApplicationRecord

 belongs_to :user
 has_many :flags
 has_many :flagging_users, through: :flags, source: :user

 validates :story_id, uniqueness: true
 validates :title, presence: true
 validates :url, presence: true

 attribute :flagged, :boolean, default: false
end
