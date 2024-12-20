FROM nginx:latest as builder

# --- ARGS vars
# ARG STATIC_FOLDER

# --- Environment and ARGS vars
ENV APP_ROOT      /nginx

# --- System installs
# RUN apt-get update -qq && apt-get install -y apt-utils build-essential freetds-dev
# RUN apt-get update

# --- Init
RUN mkdir -p $APP_ROOT/www

# --- Adding default files
COPY www/. ${APP_ROOT}/www/

# --- Create symlink for static files
# RUN /bin/bash -c "ln -s ${APP_ROOT}/www/. ${APP_ROOT}/www/${STATIC_FOLDER}"

# --- Expose port
EXPOSE 80


# --------------------------------------------------
# SPECIFIC FOR PRODUCTION
# --------------------------------------------------
FROM builder AS prod
COPY configs/nginx.prod.conf /etc/nginx/nginx.conf


# --------------------------------------------------
# SPECIFIC FOR DEVELOPMENT
# --------------------------------------------------
FROM builder AS dev

COPY configs/nginx.dev.conf /etc/nginx/nginx.conf


# --------------------------------------------------
# SPECIFIC FOR TEST
# --------------------------------------------------
FROM builder AS test

COPY configs/nginx.test.conf /etc/nginx/nginx.conf
