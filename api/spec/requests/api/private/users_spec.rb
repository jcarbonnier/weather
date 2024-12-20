# rubocop:disable RSpec/EmptyExampleGroup, RSpec/VariableName
require 'swagger_helper'

RSpec.describe 'Api::Private::Users', type: :request do
  let(:user) { current_user }
  let(:weather_location) { create(:weather_location, user: user) }
  let(:Authorization) { "Bearer #{user.token}" }

  path '/api/users/{id}' do
    let(:id) { user.id }

    get('show user') do
      tags 'Private'
      description 'Get a user'
      consumes    'application/vnd.api+json'
      produces    'application/vnd.api+json'
      security    [bearer_auth: []]

      parameter name: :id, in: :path, type: :integer, required: true, description: 'User id.', example: 1

      response(200, 'successful') do
        schema(Swagger::Schemas::User::SINGLE_ANSWER)
        run_test! do |response|
          result = JSON.parse(response.body)
          expect(result['data']['id'].to_i).to eq(user.id)
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
  end
end
# rubocop:enable RSpec/EmptyExampleGroup, RSpec/VariableName
