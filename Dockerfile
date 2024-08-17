FROM ruby:3.1.2

# RUN apt-get update
# RUN apt-get install nodejs -y
RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs

RUN gem install bundler -v 2.3.22

WORKDIR /topnews

COPY .ruby-version /topnews/
COPY Gemfile* /topnews/

# RUN bundle _2.3.22_ install
RUN bundle install

EXPOSE 3000

COPY . /topnews

CMD ["rails", "server", "-b", "0.0.0.0"]
