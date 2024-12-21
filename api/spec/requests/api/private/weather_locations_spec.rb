# rubocop:disable RSpec/EmptyExampleGroup, RSpec/VariableName, RSpec/MultipleMemoizedHelpers, RSpec/MetadataStyle
require 'swagger_helper'

RSpec.describe 'Api::Private::WeatherLocations', type: :request, vcr: true do
  let(:Authorization) { "Bearer #{current_user.token}" }

  # -------------------------
  # GET list endpoint
  # -------------------------
  path '/api/weather_locations' do
    get('list weather_locations') do
      tags 'Private'
      description 'Get a list of weather_locations'
      consumes    'application/vnd.api+json'
      produces    'application/vnd.api+json'
      security    [bearer_auth: []]
      description <<~DESC
        <b>Get weather locations</b>

        Secured by user bearer token, the locations must belong to user
      DESC

      parameter name: 'filter[name]', in: :query, type: :string, required: false,
                description: 'Filter locations by city name',
                example: 'London'

      response '200', 'Weather_locations are listed' do
        let(:weather_locations) { create_list(:weather_location, 2, users: [current_user]) }
        let(:weather_locations2) { create_list(:weather_location, 2, users: [create(:user)]) }
        before do
          weather_locations
        end

        schema(Swagger::Schemas::WeatherLocation::COLLECTION_ANSWER)

        run_test! do |response|
          result = JSON.parse(response.body)
          expect(result['data'].count).to eq(weather_locations.size)
        end
      end

      response '200', 'weather_locations are filtered' do
        let(:weather_locations) { create_list(:weather_location, 2, users: [current_user]) }
        let(:'filter[name]') { weather_locations.first.name }

        schema(Swagger::Schemas::WeatherLocation::COLLECTION_ANSWER)

        run_test! do |response|
          result = JSON.parse(response.body)
          expect(result['data'].count).to eq(1)
        end
      end
    end

    post('create weather_location') do
      tags        'Private'
      description 'Create a weather_location'
      consumes    'application/vnd.api+json'
      produces    'application/vnd.api+json'
      security    [bearer_auth: []]
      description <<~DESC
        <b>Create weather locations</b>

        Secured by user bearer token, create a location that belongs to user
      DESC

      parameter name: :data, in: :body, required: true,
                description: 'Attributes name duration url_name are required.',
                schema: { type:       :json,
                          example:    Swagger::Schemas::WeatherLocation::WRITE_EXAMPLE,
                          properties: Swagger::Schemas::WeatherLocation::CREATE_ATTRIBUTES,
                          required:   %w[data] }

      response 201, 'WeatherLocation created' do
        schema(Swagger::Schemas::WeatherLocation::SINGLE_ANSWER)
        let(:data) do
          { data: { type:       'weather_locations',
                    attributes: attributes_for(:weather_location) } }
        end
        run_test!
      end

      response 422, 'Invalid attribute' do
        schema({ '$ref' => '#/components/schemas/ValidationError' })
        let(:data) do
          { data: { type:       'weather_locations',
                    attributes: attributes_for(:weather_location).delete(:name) } }
        end
        run_test!
      end
    end
  end

  # -------------------------
  # GET endpoint
  # -------------------------
  path '/api/weather_locations/{id}' do
    let(:weather_location) { create(:weather_location, users: [current_user]) }
    let(:id) { weather_location.id }

    parameter name: :id, in: :path, type: :integer, required: true,
              description: 'WeatherLocation id.',
              example: 1

    get('show weather_location') do
      tags 'Private'
      description 'Get a weather_location'
      consumes    'application/vnd.api+json'
      produces    'application/vnd.api+json'
      security    [bearer_auth: []]
      description <<~DESC
        <b>Get a weather_location</b>

        Secured by user bearer token, the weather_location must belong to the same user
      DESC

      response(200, 'successful') do
        schema(Swagger::Schemas::WeatherLocation::SINGLE_ANSWER)
        run_test! do |response|
          result = JSON.parse(response.body)
          expect(result['data']['id'].to_i).to eq(weather_location.id)
        end
      end

      response(401, 'not authorized') do
        let(:Authorization) { "Bearer 'wrong key" }
        run_test!
      end

      response(404, 'not found') do
        let(:id) { 0 }
        run_test!
      end
    end

    # -------------------------
    # DELETE endpoint
    # -------------------------
    delete('delete weather_location') do
      tags 'Private'
      description 'Delete a weather_location'
      consumes    'application/vnd.api+json'
      produces    'application/vnd.api+json'
      security    [bearer_auth: []]
      description <<~DESC
        <b>Delete a weather_location</b>

        Secured by user bearer token, the weather_location must belong to the same user
      DESC

      response(204, 'successful') do
        run_test!
      end

      response(404, 'not found') do
        let(:user2) { create(:user) }
        let(:Authorization) { "Bearer #{user2.token}" }

        run_test!
      end
    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup, RSpec/VariableName, RSpec/MultipleMemoizedHelpers, RSpec/MetadataStyle
