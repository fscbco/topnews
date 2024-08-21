# Top News: Internal Team News Feed

## Introduction

[Hacker News](https://news.ycombinator.com/) is a well-known technology news aggregator service and forum maintained by seed stage investment firm, Y-Combinator. Via Firebase, Y-Combinator provides a simple JSON API to retrieve story information. The API requires no authentication and is documented in a [GitHub repo](https://github.com/HackerNews/API). The two most useful API calls are:

* [List of top stories](https://hacker-news.firebaseio.com/v0/topstories.json)
* [Show story details](https://hacker-news.firebaseio.com/v0/item/8863.json)


## Features

* Users can sign in and out. Must be authenticated to view stories.
* Users visits top news page and sees a list of current top Hacker News stories.
* The stories available a paginated and a backgrounf job adds new stories every 3 minutes.
* The user is able to pin a story.
* The stories pinned by the team members display in both all news and pinned news tabs.
* Each story should shows the name of the team member who flagged it.
* Each story allows the member who added it to unpin it.


## Installation

Run the following commands on your terminal to the app.
  If ruby version doesn't load properly please run `rbenv local 3.2.2` or equivalent command based your ruby version manager.

- `bundle install`
- `rails db:create`
- `rails db:migrate`
- `rails db:seed`
- `rails server`
- `POLLING_INTERVAL=3m bundle exec sidekiq`
