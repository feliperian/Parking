FROM ruby:2.6.5

# Install postgres-client
RUN apt-get update && apt-get install -y \
    postgresql-client \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV RAILS_VERSION 5.2.3

RUN gem install rails --version "$RAILS_VERSION"

WORKDIR /usr/src
