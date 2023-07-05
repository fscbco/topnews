class Story < ApplicationRecord
    has_many :stars
    has_many :users, through: :stars, dependent: :destroy

    def pretty_time
        "#{time&.strftime('%d %b, %Y')} <br>#{time&.strftime('%l:%M')}"
    end
end