#!usr/bin/ruby
# frozen_string_literal: true

# Sidekiq monitor
# Required packages
require 'sidekiq'
require 'sidekiq-status'
require 'sidekiq-cron'
require 'tzinfo'

# Set external encoding to avoid invalid byte sequence when displaying unicode
Encoding.default_external = Encoding::UTF_8

# Configure client
Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] || 'redis://localhost:6379/0' }
end

require 'set'
require 'rack/session'
require 'sidekiq/web'
require 'sidekiq-status/web'
require 'sidekiq/cron/web'

# Sidekiq::Web.set :session_secret, ENV['SECRET_KEY_BASE']
use Rack::Session::Cookie, secret: ENV['SECRET_KEY_BASE'], same_site: true, max_age: 86_400

# Basic auth
Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == ENV['SIDEKIQ_MONITOR_USER'] && password == ENV['SIDEKIQ_MONITOR_PASSWORD']
end

# Sidekiq web
route_path = ENV['SIDEKIQ_MONITOR_PATH'] || '/sidekiq'
map route_path do
  run Sidekiq::Web
end
# run Rack::URLMap.new(ENV['SIDEKIQ_ROOT_PATH'] => Sidekiq::Web)
