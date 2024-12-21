# rubocop:disable RSpec/EmptyExampleGroup, RSpec/VariableName
require 'swagger_helper'

RSpec.describe 'Api::Private::WeatherForecasts', type: :request do
  let(:Authorization) { "Bearer #{current_user.token}" }
  let(:weather_location) { create(:weather_location, users: [current_user]) }

  # -------------------------
  # GET list endpoint
  # -------------------------
  path '/api/weather_forecasts' do
    get('list weather_forecasts') do
      tags 'Private'
      description 'Get a list of weather_forecasts'
      consumes    'application/vnd.api+json'
      produces    'application/vnd.api+json'
      security    [bearer_auth: []]
      description <<~DESC
        <b>Get weather forecasts</b>

        Secured by user bearer token, the forecasts must belong to user
      DESC

      parameter name: 'filter[weather_location_id]', in: :query, type: :integer, required: false,
                description: 'Filter forecasts by location id',
                example: 1
      parameter name: 'filter[current_date]', in: :query, type: :date, required: false,
                description: 'Filter forecasts by current _date',
                example: '2024-01-30'

      before do
        inside
        outside
      end

      response '200', 'Weather_forecasts are listed' do
        schema(Swagger::Schemas::WeatherForecast::COLLECTION_ANSWER)

        let(:inside) { create_list(:weather_forecast, 2, weather_location: weather_location) }
        let(:outside) { create_list(:weather_forecast, 2, weather_location: create(:weather_location, users: [create(:user)])) }

        run_test! do |response|
          result = JSON.parse(response.body)
          expect(result['data'].count).to eq(inside.size)
        end
      end

      response '200', 'weather_forecasts are filtered' do
        schema(Swagger::Schemas::WeatherForecast::COLLECTION_ANSWER)

        let(:inside) { create(:weather_forecast, weather_location: weather_location) }
        let(:outside) { create(:weather_forecast, weather_location: create(:weather_location, users: [current_user])) }
        let(:'filter[weather_location_id]') { weather_location.id }

        run_test! do |response|
          result = JSON.parse(response.body)
          expect(result['data'].count).to eq(1)
        end
      end
    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup, RSpec/VariableName
