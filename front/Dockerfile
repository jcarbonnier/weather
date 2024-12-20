# --------------------------------------------------
# BASE IMAGE
# --------------------------------------------------
FROM node:22-alpine AS builder

# --- Environment vars
ENV APP_ROOT  /front

# --- System installs
RUN apk update && apk add --no-cache chromium chromium-chromedriver

# --- Init
WORKDIR $APP_ROOT

# --- Adding default files
COPY package.json package-lock.json .npmrc $APP_ROOT/

# --- Ports
EXPOSE 4200

# --- Command (cf. package.json)
CMD ["npm", "start"]


# --------------------------------------------------
# SPECIFIC FOR DEVELOPMENT
# --------------------------------------------------
FROM builder AS dev

# --- Arguments vars
ARG GITLAB_REGISTRY_TOKEN

# --- App install packages
RUN npm install --legacy-peer-deps && npm cache clean --force
# RUN yarn install && yarn cache clean
# --verbose

# --- App : copy here to prevent bundle install eveytime
# NO NEED TO COPY IN DEVELOPMENT: folder is mounted as a volume
# COPY . $APP_ROOT


# --------------------------------------------------
# SPECIFIC FOR TEST
# --------------------------------------------------
FROM builder AS test

# --- Arguments vars
ARG GITLAB_REGISTRY_TOKEN

# --- Source code
COPY . $APP_ROOT
