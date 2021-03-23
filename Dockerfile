FROM ruby:2.7.2
WORKDIR /myapp
RUN apt-get update && apt install -y \
        build-essential libpq-dev cron
RUN service cron start
COPY Gemfile* /myapp/
ENV GEM_HOME="/usr/local/bundle"
RUN gem install bundler --no-document -v '2.2.15' && bundle install

COPY . /myapp
RUN bundle exec whenever -c && bundle exec whenever --update-crontab && touch ./log/cron.log