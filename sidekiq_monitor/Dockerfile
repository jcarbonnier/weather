# --------------------------------------------------
# BASE IMAGE
# --------------------------------------------------
FROM registry.ad.softier.fr/softier/commons/ruby:3.2.3-alpine AS builder

# --- Environment vars
ENV APP_ROOT      /sidekiq_monitor

# --- System installs
RUN apk update && apk add build-base coreutils tzdata
# ENV TZ Europe/Paris

# --- Init
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

# --- Adding default files
COPY Gemfile Gemfile.lock config.ru .gemrc $APP_ROOT/

# --- App install packages
# RUN echo $RAILS_ENV $GEM_HOME $BUNDLE_PATH
# RUN gem install rack sidekiq redis-namespace sidekiq-status sidekiq-cron tzinfo tzinfo-data

# --- Ports
EXPOSE 9292

# --- Command
CMD ["bundle", "exec", "rackup", "config.ru", "--host", "0.0.0.0"]


# --------------------------------------------------
# SPECIFIC FOR PRODUCTION
# --------------------------------------------------
FROM builder AS prod

# The test stage installs the test dependencies
RUN bundle lock --add-platform x86_64-linux-musl && \
    bundle config set deployment 'true' && \
    bundle config set without 'development test' && \
    bundle install -j 1


# --------------------------------------------------
# SPECIFIC FOR DEVELOPMENT / TESTING
# --------------------------------------------------
FROM builder AS dev

# The test stage installs the test dependencies
RUN bundle lock --add-platform x86_64-linux-musl && \
    bundle install -j $(nproc)

# --- App : copy here to prevent bundle install eveytime
COPY . $APP_ROOT
