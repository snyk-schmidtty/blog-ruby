FROM ruby:2.5-slim

ARG APP_USER=appuser
ARG APP_GROUP=appgroup
ARG APP_DIR=/blog

RUN apt-get update &&\
    apt-get install -y sqlite3 &&\
    rm -rf /var/lib/apt/lists/* &&\
    addgroup --system $APP_GROUP && \
    adduser --system --uid 101 --ingroup $APP_GROUP $APP_USER && \
    mkdir $APP_DIR && \
    chown $APP_USER:$APP_GROUP $APP_DIR 

RUN gem update --system 3.1.2 &&\
    gem install bundler -v '2.1.2'

USER $APP_USER
WORKDIR $APP_DIR

COPY --chown=$APP_USER:$APP_GROUP --from=purpledobie/blog:gems-good /blog .

ENV BUNDLER_VERSION 2.1.2
ENV RAILS_ENV=development
RUN bundle config --local path vendor/bundle && bundle config --local without assets &&\
    bundle exec rails db:setup &&\
    bundle exec rails db:migrate

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
