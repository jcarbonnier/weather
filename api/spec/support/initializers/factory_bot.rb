# frozen_string_literal: true

require 'factory_bot'

# Loading all the factories.
# Dir[Rails.root + 'spec/factories/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  # Making methods like `create` or `build` accessible without the need
  # of `FactoryBot.` everywhere.
  config.include FactoryBot::Syntax::Methods
end
