FROM ruby:2.7.3

WORKDIR /app

COPY ../../app/Gemfile /app/Gemfile

RUN ["bundle", "install", "--path", "vendor/bundle"]
