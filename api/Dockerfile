# --------------------------------------------------
# BASE IMAGE
# --------------------------------------------------
FROM ruby:3.2.5-alpine AS builder
# FROM ruby:3.2.3-alpine AS builder
# FROM ruby:3.1-alpine AS builder
# FROM ruby:2.6-alpine AS builder

# --- ARGS vars
# ARG BUNDLE_ARGS
# RUN echo ${BUNDLE_ARGS}

# --- Environment vars
ENV APP_ROOT      /api

# --- System installs
RUN apk update && apk add --no-cache build-base coreutils tzdata postgresql-dev

# --- Init
WORKDIR $APP_ROOT

# --- Adding default files
COPY Gemfile Gemfile.lock .gemrc $APP_ROOT/

# --- App install packages
# RUN echo $RAILS_ENV $GEM_HOME $BUNDLE_PATH
# RUN bundle install --without development test -j $(nproc)

# --- Ports
EXPOSE 3000

# --- Command
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]


# --------------------------------------------------
# SPECIFIC FOR PRODUCTION
# --------------------------------------------------
FROM builder AS prod

# The test stage installs the test dependencies
RUN bundle config set deployment 'true' && \
    bundle config set without 'development test' && \
    bundle install -j 1

# --- App : copy here to prevent bundle install eveytime
COPY . $APP_ROOT


# --------------------------------------------------
# SPECIFIC FOR DEVELOPMENT / TESTING
# --------------------------------------------------
FROM builder AS dev

# --- System install
RUN apk update && apk add --no-cache git

# --- Install dev the dependencies
RUN bundle install -j $(nproc)

# --- App : copy here to prevent bundle install eveytime
# NO NEED TO COPY IN DEVELOPMENT: folder is mounted as a volume
# COPY . $APP_ROOT


# --------------------------------------------------
# SPECIFIC FOR TESTING
# --------------------------------------------------
FROM builder AS test

# --- System install
RUN apk update && apk add --no-cache git

# --- Install test the dependencies
# Many retry errors when enabling parallel downloads
# RUN bundle install -j $(nproc)
RUN bundle install -j 1

# --- App : copy here to prevent bundle install eveytime
COPY . $APP_ROOT
