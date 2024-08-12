Rails.application.config.after_initialize do
    if Article.count.zero?
        FetchTopStoriesJob.perform_later
    end
end