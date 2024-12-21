# rubocop:disable RSpec/EmptyExampleGroup, RSpec/VariableName, RSpec/MetadataStyle
require 'swagger_helper'

RSpec.describe 'Api::Private::Locations', type: :request, vcr: true do
  let(:Authorization) { "Bearer #{current_user.token}" }

  # -------------------------
  # GET list endpoint
  # -------------------------
  path '/api/locations' do
    get('list locations') do
      tags 'Private'
      description 'Get a list of distant locations'
      consumes    'application/vnd.api+json'
      produces    'application/vnd.api+json'
      security    [bearer_auth: []]
      description <<~DESC
        <b>Get weather distant locations</b>

        Secured by user bearer token, the locations are external
      DESC

      parameter name: 'filter[name]', in: :query, type: :integer, required: true,
                description: 'Filter locations by location id',
                example: 'singapour'

      response '200', 'Weather_locations are listed' do
        let(:'filter[name]') { 'singapour' }

        schema(Swagger::Schemas::WeatherLocation::COLLECTION_ANSWER)

        run_test! do |response|
          result = JSON.parse(response.body)
          expect(result['data'].count).to eq(1)
        end
      end
    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup, RSpec/VariableName, RSpec/MetadataStyle
