class Story < ApplicationRecord
    has_many :stars
    has_many :users through: :stars

end