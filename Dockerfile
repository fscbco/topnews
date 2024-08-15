# Use a specific version of Ruby as the base image
FROM ruby:3.1.2 AS base

# Install dependencies for building Ruby gems and Node.js/Yarn
RUN apt-get update && apt-get install -y --no-install-recommends build-essential libssl-dev libffi-dev nodejs yarn && rm -rf /var/lib/apt/lists/*

# Set the working directory and create necessary directories
WORKDIR /topnews
RUN mkdir -p /topnews
# copy files to the images
COPY . /topnews
# Install Ruby gems
RUN gem install rails bundler && bundle install

RUN chmod +x /topnews/bin/docker-entrypoint.sh
ENTRYPOINT ["/topnews/bin/docker-entrypoint.sh"]