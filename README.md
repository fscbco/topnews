# Top News: Internal Team News Feed

In order to evaluate your stengths as a developer, we are requesting you complete a brief take-home code challenge that involves some work on the full web stack. We expect this to take 2 to 4 hours of your time. After developing your solution, please submit a Pull Request on Github and we will discuss your code on a screenshare at the next interview.

## Introduction

[Hacker News](https://news.ycombinator.com/) is a well-known technology news aggregator service and forum maintained by seed stage investment firm, Y-Combinator. Via Firebase, Y-Combinator provides a simple JSON API to retrieve story information. The API requires no authentication and is documented in a [GitHub repo](https://github.com/HackerNews/API). The two most useful API calls are:

* [List of top stories](https://hacker-news.firebaseio.com/v0/topstories.json)
* [Show story details](https://hacker-news.firebaseio.com/v0/item/8863.json)

Suppose you have a small team of developers who all regularly browse Hacker News for industry insights. This team would like a simple way to flag articles that could be of interest to other team members and publish that list out to the rest of the team. This UI would be deployed for internal use so it would not require a public sign up but would be pre-populated with users who will be team members.

When a team member signs in, they will see recent news stories and be able to star, flag, highlight, or otherwise mark a story as interesting. A separate list should display all the stories that were deemed interesting and the name of the person who marked it so.

## Requirements

* Users should sign in and out. We have created a User model for you and pre-populated it with several users.
* Users should come to a page and see a list of current top Hacker News stories.
* This list does not necessarily need to be the current live list, but it should be a recent and continuously updated list.
* The number of stories displayed is up to you.
* The user should be able to star a story. The mechanism and display is up to you: flag, star, upvote, pick, etc. The UX is your choice.
* The stories chosen by the team members should display. It can be a separate page or the same page, the choice is yours.
* Each story should show the name of the team member or members who flagged it.
* As an internal tool for a small team, performance optimization is not a requirement.
* Be prepared to discuss known performance shortcomings of your solution and potential improvements.
* UX design here is of little importance. The design can be minimal or it can have zero design at all.


# Running the environment (local)

## Requirements

```
ruby 3.1.2
postgres 14.4
```

Manage requirements using `asdf`:

-  [`asdf` - Getting Started](https://asdf-vm.com/guide/getting-started.html)

`asdf` requirements versions are specified in the file `.tool-versions` for `asdf`:

```bash
cat .tool-versions
```

## Setup

```bash
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

## Running the server

```bash
bundle exec rails server
```

# Running tests

## Setup

```bash
bundle exec rails db:migrate RAILS_ENV=test
```

## Running tests

```bash
bundle exec rspec
# or
bundle exec rspec --format documentation
```

# Running the environment (Docker)

Build image using multi-platform images

```bash
docker build --platform linux/amd64 .
```

## Development

Run the environment

```bash
docker compose up
```

Stoping the environment

```bash
docker compose down -v
```

## Helpful commands

Get services `CONTAINER_ID` or `NAMES`:

```bash
docker ps
```

Using the `CONTAINER_ID` or `NAMES` from the previous command,
we can execute commands against our docker services

First time commands:
```bash
docker exec -it <CONTAINER_ID> bundle exec rails db:create
docker exec -it <CONTAINER_ID> bundle exec rails db:migrate
docker exec -it <CONTAINER_ID> bundle exec rails db:seed
```

Rails console in container:
```bash
# This will be similar run against running server
docker exec -it <CONTAINER_ID> bundle exec rails console
```

Rails console from service:
```bash
# This will be similar to running `bundle exec rails console`
docker compose run rails bundle exec rails console
```

## Running tests

First steps for setup
```bash
docker compose -f docker-compose.test.yml run test bundle exec rails db:test:prepare
```

### Running tests suite

Running tests suite
```bash
docker compose -f docker-compose.test.yml run test bundle exec rspec --format documentation
```

Running tests in container
```bash
docker compose -f docker-compose.test.yml up
```

