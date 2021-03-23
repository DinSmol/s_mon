FROM ruby:2.7.2
WORKDIR /myapp
RUN apt-get update && apt install -y \
        build-essential libpq-dev cron
RUN service cron start
COPY Gemfile* /myapp/
#ENV BUNDLER_VERSION='2.2.15'
#ENV BUNDLE_PATH="/usr/local/bundle"
ENV GEM_HOME="/usr/local/bundle"
#ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH
RUN gem install bundler --no-document -v '2.2.15' && bundle install

COPY . /myapp
RUN bundle exec whenever -c && bundle exec whenever --update-crontab && touch ./log/cron.log
#ENTRYPOINT ["./Docker/entry"]