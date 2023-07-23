class Story < ApplicationRecord
    has_many :flags, class_name: 'Flag'
    has_many :flagging_users, through: :flags, source: :user
end
