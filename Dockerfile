FROM ruby:3.2.2
RUN apt update
RUN apt install -y nodejs
RUN gem install bundler
RUN mkdir -p /app
WORKDIR /app
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY .ruby-version .ruby-version
RUN bundle install --path vendor/bundle
COPY . .
RUN bundle install
EXPOSE 3000