# to speed up builds all the ruby gems are pre-built & web assets pre-compiled
# this dockerfile creates that builder image but since the image is stored on Docker Hub this 
# step does not need to be run unless there are ruby, rails, or gem version changes needed

# This file is for the 'badder' gems.

FROM ruby:2.5.1

RUN gem update --system 3.0.4 &&\
    gem install bundler -v '2.0.2'

ENV APP_HOME /blog
WORKDIR $APP_HOME

COPY Gemfile* .

ENV BUNDLER_VERSION 2.0.2
ENV RAILS_ENV=development

RUN bundle update &&\
    bundle install --deployment

COPY . $APP_HOME
RUN bundle exec rake assets:precompile &&\
    rm -rf $APP_HOME/node_modules && rm -rf $APP_HOME/tmp/*