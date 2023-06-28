class Source < ApplicationRecord
    HACKER_NEWS = 'Hacker News'

    def hacker_news?
        name == HACKER_NEWS
    end
end
