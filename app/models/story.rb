class Story < ApplicationRecord

 belongs_to :user
 has_many :flags
 has_many :flagging_users, through: :flags, source: :user

 validates :story_id, uniqueness: true

 attribute :flagged, :boolean, default: false
 attribute :flagged_by, :integer
end
